package com.jignesh.service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.font.Standard14Fonts;
import org.springframework.stereotype.Service;

import com.jignesh.entity.Appointment;
import com.jignesh.entity.Doctor;
import com.jignesh.entity.Patient;

@Service
public class PdfExportService {

	public byte[] generateDoctorsPdf(List<Doctor> doctors) throws IOException {
		return generateSimplePdf("Doctors Report", doctors.stream()
				.map(d -> d.getId() + " | " + d.getUser().getName() + " | " + d.getSpecialization()).toList());
	}

	public byte[] generatePatientsPdf(List<Patient> patients) throws IOException {
		return generateSimplePdf("Patients Report",
				patients.stream().map(p -> p.getId() + " | " + p.getUser().getName() + " | " + p.getPhone()).toList());
	}

	public byte[] generateAppointmentsPdf(List<Appointment> appointments) throws IOException {
		return generateSimplePdf("Appointments Report", appointments.stream()
				.map(a -> a.getId() + " | " + a.getPatient().getUser().getName() + " | "
						+ a.getDoctor().getUser().getName() + " | " + a.getAppointmentDate() + " | " + a.getStatus())
				.toList());
	}

	private byte[] generateSimplePdf(String title, List<String> lines) throws IOException {
		try (PDDocument document = new PDDocument(); ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {
			PDPage page = new PDPage(PDRectangle.A4);
			document.addPage(page);

			try (PDPageContentStream contentStream = new PDPageContentStream(document, page)) {
				contentStream.beginText();
				contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD), 16);
				contentStream.newLineAtOffset(50, 780);
				contentStream.showText(title);
				contentStream.endText();

				float y = 750;
				for (String line : lines) {
					if (y < 50) {
						break;
					}
					contentStream.beginText();
					contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA), 10);
					contentStream.newLineAtOffset(50, y);
					contentStream.showText(line.length() > 100 ? line.substring(0, 100) : line);
					contentStream.endText();
					y -= 15;
				}
			}

			document.save(outputStream);
			return outputStream.toByteArray();
		}
	}
}