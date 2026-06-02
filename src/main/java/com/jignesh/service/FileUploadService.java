package com.jignesh.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileUploadService {

	@Value("${app.upload.dir:uploads}")
	private String uploadDir;

	public String saveImage(MultipartFile file) throws IOException {
		if (file == null || file.isEmpty()) {
			return null;
		}

		String contentType = file.getContentType();
		if (contentType == null || !contentType.startsWith("image/")) {
			throw new IllegalArgumentException("Only image files are allowed");
		}

		Path uploadPath = Paths.get(uploadDir);
		Files.createDirectories(uploadPath);

		String originalFileName = file.getOriginalFilename();
		String extension = ".png";

		if (originalFileName != null && originalFileName.contains(".")) {
			extension = originalFileName.substring(originalFileName.lastIndexOf("."));
		}

		String fileName = UUID.randomUUID() + extension;
		Path targetPath = uploadPath.resolve(fileName);
		Files.copy(file.getInputStream(), targetPath, StandardCopyOption.REPLACE_EXISTING);
		return fileName;
	}

	public void deleteImage(String fileName) {
		if (fileName == null || fileName.isBlank()) {
			return;
		}
		try {
			Files.deleteIfExists(Paths.get(uploadDir).resolve(fileName));
		} catch (IOException ignored) {
		}
	}
}