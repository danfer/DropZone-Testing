Imports System.Data.SqlClient
Imports System.Web
Imports System.Web.Services

Public Class FileUploader
    Implements System.Web.IHttpHandler

    Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest

        Try
            Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("connection").ToString())
            context.Response.ContentType = "text/plain"
            Dim FilesPath As String = HttpContext.Current.Server.MapPath("~/images/")
            Dim files As String()
            Dim uploadedfiles As String = ""
            For Each s As String In context.Request.Files
                Dim file As HttpPostedFile = context.Request.Files(s)
                Dim fileSizeInBytes As Integer = file.ContentLength
                Dim fileName As String = file.FileName
                Dim fileExtension As String = file.ContentType
                If Not String.IsNullOrEmpty(fileName) Then
                    fileExtension = System.IO.Path.GetExtension(fileName)
                    files = System.IO.Directory.GetFiles(FilesPath)
                    uploadedfiles = Guid.NewGuid().ToString() & fileName
                    Dim path As String = HttpContext.Current.Server.MapPath("~/images/") & uploadedfiles
                    file.SaveAs(path)
                    Dim cmd As SqlCommand = New SqlCommand("InsertGalleryImages", con)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.AddWithValue("@Filename", uploadedfiles)
                    cmd.Parameters.AddWithValue("@filepath", "~/images/" & uploadedfiles)
                    con.Open()
                    cmd.ExecuteNonQuery()
                End If
            Next

            context.Response.Write(uploadedfiles)
        Catch ex As Exception
            context.Response.Write("ERROR: " & ex.Message)
        End Try

    End Sub

    ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class