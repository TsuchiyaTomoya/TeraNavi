package ttc;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.fileupload.FileUploadException;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import java.io.File;

import java.util.List;
import java.util.Iterator;
import ttc.util.ImageResizer;

public class FileUploadServlet extends HttpServlet{
	public void doGet(HttpServletRequest req,HttpServletResponse res)throws IOException,ServletException{
		doPost(req,res);
	}

	public void doPost(HttpServletRequest req,HttpServletResponse res)throws IOException,ServletException{

		

		req.setCharacterEncoding("utf-8");

		String path = "/tmp";

		String resultPath = null;

		String hostName = req.getLocalName();

		int width = 0;
		int height = 0;
		
		String info = req.getPathInfo();
		if(info != null && info.equals("header")){
			width = 1500;
			height = 500;
		}else{
			width = 400;
			height = 400;
		}
		
		DiskFileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload sfu = new ServletFileUpload(factory);
		try{
			List list = sfu.parseRequest(req);
			Iterator it = list.iterator();
			while(it.hasNext()){
				FileItem item = (FileItem)it.next();

				if(!item.isFormField()){
					String fileName = item.getName();
					if((fileName!=null)&&(!fileName.equals(""))){
						File target = new File(fileName);
						fileName = target.getName();
						
						item.write(new File(path+"/"+fileName));
						
						String result=ImageResizer.doResize(new File(path+"/"+fileName), width, height,path+"/"+fileName);
						resultPath="http://"+hostName+"/TeraNavi/imgPath/"+result;
					}
				}

			}


		}catch(FileUploadException e){
			throw new IOException(e.getMessage(),e);
		}catch(Exception e){
			throw new IOException(e.getMessage(),e);
		}

		

		String responseJson = "{\"result\":\""+resultPath+"\"}";
		res.setContentType("application/json;charset=UTF-8");

		PrintWriter writer = res.getWriter();
		writer.print(responseJson);

		writer.flush();
		writer.close();
	}

	private String getFilename(Part part){
		for(String cd : part.getHeader("Content-Disposition").split(";")){
			if(cd.trim().startsWith("filename")){
				return cd.substring(cd.indexOf('=') + 1).trim().replace("\"","");
			}
		}

		return null;
	}
}
