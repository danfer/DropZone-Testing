<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="FileUpload.aspx.vb" Inherits="DropZone2.FileUpload" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.1.1/min/dropzone.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.1.1/min/dropzone.min.js"></script>

   <script type="text/javascript">
       Dropzone.autoDiscover = false;

       $(document).ready(function () {
           
           var myDropzone = new Dropzone("#dZUpload", {
               url: "FileUploader.ashx",
               autoProcessQueue: false,
               //upload more than 2 files by Dropzone.js with button
               parallelUploads: 6,
               //File size
               maxfilesize: 100,
               //Number of files
               maxFiles: 6,
               addRemoveLinks: true,
               success: function (file, response) {
                   var imgName = response;
                   file.previewElement.classList.add("dz-success");
                   console.log("Successfully uploaded :" + imgName);
               },
               error: function (file, response) {
                   file.previewElement.classList.add("dz-error");
               }
           });
           $('#btnsubmit').on('click', function (e) {
               myDropzone.processQueue();

               alert("File's uploaded successfully");
           });
       });
   </script>
</head>
<body>

     <form id="form1" runat="server">
     <div align="center">

        <div id="dZUpload" style="width:800px; margin:0 auto;" class="dropzone" >
        <div  class="dz-default dz-message">
            <br />
            <br />
            <br /><br />
           Drag & Drop files here
        </div>
    </div>
         <br />
         <asp:Button ID="btnsubmit" runat="server" Text="Save Files" />
    </div>
    </form>
    <style>
        .dz-default{
            background-image:url(images/img-upload.png);
            background-repeat:no-repeat;
            background-position: center;
        }
    </style>
</body>
</html>
