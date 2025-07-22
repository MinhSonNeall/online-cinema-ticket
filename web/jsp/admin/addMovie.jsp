<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Movie - Admin Dashboard</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
* {
margin: 0;
padding: 0;
box-sizing: border-box;
}

body {
font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
min-height: 100vh;
padding: 20px;
}

.container {
max-width: 800px;
margin: 0 auto;
background: rgba(255, 255, 255, 0.95);
border-radius: 15px;
box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
backdrop-filter: blur(10px);
border: 1px solid rgba(255, 255, 255, 0.2);
overflow: hidden;
}

.header {
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
color: white;
padding: 30px;
text-align: center;
position: relative;
}

.header h1 {
font-size: 2.5rem;
font-weight: 600;
margin-bottom: 10px;
}

.header p {
font-size: 1.1rem;
opacity: 0.9;
}

.back-btn {
position: absolute;
left: 30px;
top: 50%;
transform: translateY(-50%);
background: rgba(255, 255, 255, 0.2);
color: white;
border: none;
padding: 10px 15px;
border-radius: 8px;
cursor: pointer;
transition: all 0.3s ease;
text-decoration: none;
display: flex;
align-items: center;
gap: 8px;
}

.back-btn:hover {
background: rgba(255, 255, 255, 0.3);
transform: translateY(-50%) translateX(-2px);
}

.form-container {
padding: 40px;
}

.form-grid {
display: grid;
grid-template-columns: 1fr 1fr;
gap: 25px;
margin-bottom: 30px;
}

.form-group {
display: flex;
flex-direction: column;
}

.form-group.full-width {
grid-column: 1 / -1;
}

.form-label {
font-weight: 600;
color: #333;
margin-bottom: 8px;
font-size: 0.95rem;
}

.form-input,
.form-select,
.form-textarea {
padding: 12px 15px;
border: 2px solid #e1e5e9;
border-radius: 8px;
font-size: 1rem;
background: #f8f9fa;
transition: all 0.3s ease;
outline: none;
}

.form-input:focus,
.form-select:focus,
.form-textarea:focus {
border-color: #667eea;
background: #fff;
box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
}

.form-textarea {
resize: vertical;
min-height: 100px;
font-family: inherit;
}

.form-select {
cursor: pointer;
}

.form-input::placeholder,
.form-textarea::placeholder {
color: #adb5bd;
}

/* Multi-select styles */
.multi-select-container {
position: relative;
}

.multi-select-dropdown {
position: relative;
border: 2px solid #e1e5e9;
border-radius: 8px;
background: #f8f9fa;
cursor: pointer;
transition: all 0.3s ease;
}

.multi-select-dropdown:focus-within {
border-color: #667eea;
background: #fff;
box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
}

.multi-select-display {
padding: 12px 15px;
min-height: 48px;
display: flex;
align-items: center;
justify-content: space-between;
color: #495057;
}

.multi-select-placeholder {
color: #adb5bd;
}

.multi-select-arrow {
transition: transform 0.3s ease;
}

.multi-select-dropdown.open .multi-select-arrow {
transform: rotate(180deg);
}

.multi-select-options {
position: absolute;
top: 100%;
left: 0;
right: 0;
background: white;
border: 2px solid #667eea;
border-top: none;
border-radius: 0 0 8px 8px;
max-height: 200px;
overflow-y: auto;
z-index: 1000;
display: none;
}

.multi-select-dropdown.open .multi-select-options {
display: block;
}

.multi-select-option {
padding: 10px 15px;
cursor: pointer;
transition: background-color 0.2s ease;
display: flex;
align-items: center;
gap: 8px;
}

.multi-select-option:hover {
background-color: #f8f9fa;
}

.multi-select-option.selected {
background-color: #667eea;
color: white;
}

.multi-select-option input[type="checkbox"] {
margin: 0;
}

/* Selected tags styles */
.selected-tags {
display: flex;
flex-wrap: wrap;
gap: 8px;
margin-top: 10px;
min-height: 20px;
}

.tag {
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
color: white;
padding: 6px 12px;
border-radius: 20px;
font-size: 0.85rem;
display: flex;
align-items: center;
gap: 6px;
animation: tagAppear 0.3s ease;
}

.tag-remove {
background: rgba(255, 255, 255, 0.2);
border: none;
color: white;
border-radius: 50%;
width: 18px;
height: 18px;
display: flex;
align-items: center;
justify-content: center;
cursor: pointer;
font-size: 0.7rem;
transition: all 0.2s ease;
}

.tag-remove:hover {
background: rgba(255, 255, 255, 0.3);
transform: scale(1.1);
}

@keyframes tagAppear {
from {
opacity: 0;
transform: scale(0.8);
}
to {
opacity: 1;
transform: scale(1);
}
}

/* File Upload Styles */
.upload-container {
display: flex;
flex-direction: column;
gap: 10px;
}

.upload-options {
display: flex;
gap: 10px;
margin-bottom: 10px;
}

.upload-option {
flex: 1;
padding: 8px 12px;
border: 2px solid #e1e5e9;
border-radius: 6px;
background: #f8f9fa;
cursor: pointer;
text-align: center;
font-size: 0.9rem;
transition: all 0.3s ease;
color: #6c757d;
}

.upload-option.active {
border-color: #667eea;
background: #667eea;
color: white;
}

.upload-option:hover {
border-color: #667eea;
background: rgba(102, 126, 234, 0.1);
}

.upload-option.active:hover {
background: #5a67d8;
}

.file-upload-area {
border: 2px dashed #e1e5e9;
border-radius: 8px;
padding: 30px;
text-align: center;
background: #f8f9fa;
transition: all 0.3s ease;
cursor: pointer;
position: relative;
overflow: hidden;
}

.file-upload-area:hover {
border-color: #667eea;
background: rgba(102, 126, 234, 0.05);
}

.file-upload-area.dragover {
border-color: #667eea;
background: rgba(102, 126, 234, 0.1);
}

.file-upload-content {
display: flex;
flex-direction: column;
align-items: center;
gap: 10px;
color: #6c757d;
}

.file-upload-icon {
font-size: 2rem;
color: #667eea;
}

.file-upload-text {
font-size: 1rem;
font-weight: 500;
}

.file-upload-subtext {
font-size: 0.85rem;
color: #adb5bd;
}

.file-input {
position: absolute;
top: 0;
left: 0;
width: 100%;
height: 100%;
opacity: 0;
cursor: pointer;
}

.file-preview {
margin-top: 10px;
padding: 10px;
background: #e9ecef;
border-radius: 6px;
display: none;
align-items: center;
gap: 10px;
}

.file-preview.show {
display: flex;
}

.file-preview-icon {
color: #28a745;
}

.file-preview-name {
flex: 1;
font-size: 0.9rem;
color: #495057;
}

.file-preview-remove {
background: #dc3545;
color: white;
border: none;
border-radius: 4px;
padding: 4px 8px;
cursor: pointer;
font-size: 0.8rem;
}

.file-preview-remove:hover {
background: #c82333;
}

.error-message {
background: #fee;
color: #c33;
padding: 12px 15px;
border-radius: 8px;
margin-bottom: 20px;
border-left: 4px solid #c33;
display: flex;
align-items: center;
gap: 8px;
font-size: 14px;
}

.success-message {
background: #efe;
color: #3c3;
padding: 12px 15px;
border-radius: 8px;
margin-bottom: 20px;
border-left: 4px solid #3c3;
display: flex;
align-items: center;
gap: 8px;
font-size: 14px;
}

.button-group {
display: flex;
gap: 15px;
justify-content: center;
margin-top: 30px;
}

.btn {
padding: 12px 30px;
border: none;
border-radius: 8px;
font-size: 1rem;
font-weight: 600;
cursor: pointer;
transition: all 0.3s ease;
display: flex;
align-items: center;
gap: 8px;
text-decoration: none;
}

.btn-primary {
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
color: white;
}

.btn-primary:hover {
transform: translateY(-2px);
box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
}

.btn-secondary {
background: #6c757d;
color: white;
}

.btn-secondary:hover {
background: #5a6268;
transform: translateY(-2px);
box-shadow: 0 8px 25px rgba(108, 117, 125, 0.3);
}

.preview-section {
margin-top: 30px;
padding: 20px;
background: #f8f9fa;
border-radius: 8px;
border: 2px dashed #dee2e6;
}

.preview-title {
font-weight: 600;
color: #333;
margin-bottom: 15px;
display: flex;
align-items: center;
gap: 8px;
}

.preview-content {
display: grid;
grid-template-columns: 200px 1fr;
gap: 20px;
align-items: start;
}

.poster-preview {
width: 100%;
height: 280px;
background: #e9ecef;
border-radius: 8px;
display: flex;
align-items: center;
justify-content: center;
color: #6c757d;
font-size: 0.9rem;
overflow: hidden;
flex-direction: column;
gap: 8px;
position: relative;
}

.poster-preview img {
width: 100%;
height: 100%;
object-fit: cover;
border-radius: 8px;
}

.poster-error {
display: none;
flex-direction: column;
align-items: center;
gap: 8px;
color: #dc3545;
}

.movie-info {
display: flex;
flex-direction: column;
gap: 10px;
}

.info-item {
display: flex;
gap: 10px;
}

.info-label {
font-weight: 600;
color: #495057;
min-width: 120px;
}

.info-value {
color: #6c757d;
}

/* Responsive */
@media (max-width: 768px) {
.container {
margin: 10px;
}

.header {
padding: 20px;
}

.header h1 {
font-size: 2rem;
}

.back-btn {
position: static;
transform: none;
margin-bottom: 15px;
align-self: flex-start;
}

.form-container {
padding: 20px;
}

.form-grid {
grid-template-columns: 1fr;
gap: 20px;
}

.button-group {
flex-direction: column;
}

.preview-content {
grid-template-columns: 1fr;
gap: 15px;
}

.poster-preview {
height: 200px;
}

.upload-options {
flex-direction: column;
}
}

/* Loading Animation */
.loading {
opacity: 0.7;
pointer-events: none;
}

.loading .btn-primary {
background: linear-gradient(45deg, #aaa, #ccc);
}

.loading .btn-primary::after {
content: '';
width: 16px;
height: 16px;
border: 2px solid transparent;
border-top: 2px solid #fff;
border-radius: 50%;
animation: spin 1s linear infinite;
display: inline-block;
margin-left: 8px;
}

@keyframes spin {
0% { transform: rotate(0deg); }
100% { transform: rotate(360deg); }
}
</style>
</head>
<body>
<div class="container">
<div class="header">
<a href="${pageContext.request.contextPath}/ManageMovie" class="back-btn">
<i class="fas fa-arrow-left"></i>
Back to Movies
</a>
<h1>Add New Movie</h1>
<p>Create a new movie entry for the cinema system</p>
</div>

<div class="form-container">
<% if (request.getAttribute("error") != null) { %>
<div class="error-message">
<i class="fas fa-exclamation-circle"></i>
<%= request.getAttribute("error") %>
</div>
<% } %>

<% if (request.getAttribute("success") != null) { %>
<div class="success-message">
<i class="fas fa-check-circle"></i>
<%= request.getAttribute("success") %>
</div>
<% } %>

<form action="${pageContext.request.contextPath}/ManageMovie" method="post" enctype="multipart/form-data" id="addMovieForm">
<input type="hidden" name="service" value="add">
<div class="form-grid">
<div class="form-group">
<label for="movieName" class="form-label">
<i class="fas fa-film"></i> Tên phim *
</label>
<input type="text" id="movieName" name="movieName" class="form-input"
placeholder="Nhập tên phim" required>
</div>

<div class="form-group">
<label for="duration" class="form-label">
<i class="fas fa-clock"></i> Thời lượng (phút) *
</label>
<input type="number" id="duration" name="duration" class="form-input"
placeholder="120" min="1" max="500" required>
</div>

<div class="form-group">
<label for="ageLimit" class="form-label">
<i class="fas fa-user-shield"></i> Giới hạn độ tuổi *
</label>
<select id="ageLimit" name="ageLimit" class="form-select" required>
<option value="">Chọn giới hạn độ tuổi</option>
<option value="0">Phù hợp mọi lứa tuổi</option>
<option value="13">T13 - Từ 13 tuổi trở lên</option>
<option value="16">T16 - Từ 16 tuổi trở lên</option>
<option value="18">T18 - Từ 18 tuổi trở lên</option>
</select>
</div>

<!-- Multi-select Genres -->
<div class="form-group">
<label class="form-label">
<i class="fas fa-tags"></i> Thể loại *
</label>
<div class="multi-select-container">
<div class="multi-select-dropdown" id="genreDropdown">
<div class="multi-select-display">
<span class="multi-select-placeholder">Chọn thể loại</span>
<i class="fas fa-chevron-down multi-select-arrow"></i>
</div>
<div class="multi-select-options">
<c:forEach var="genre" items="${requestScope.genresList}">
<div class="multi-select-option" data-value="${genre.genre_id}" data-text="${genre.name}">
<input type="checkbox" id="genre${genre.genre_id}">
<label for="genre${genre.genre_id}">${genre.name}</label>
</div>
</c:forEach>
</div>
</div>
<div class="selected-tags" id="selectedGenres"></div>
<!-- Hidden inputs for selected genres -->
<div id="genreHiddenInputs"></div>
</div>
</div>

<!-- Multi-select Producers -->
<div class="form-group">
<label class="form-label">
<i class="fas fa-building"></i> Nhà sản xuất *
</label>
<div class="multi-select-container">
<div class="multi-select-dropdown" id="producerDropdown">
<div class="multi-select-display">
<span class="multi-select-placeholder">Chọn nhà sản xuất</span>
<i class="fas fa-chevron-down multi-select-arrow"></i>
</div>
<div class="multi-select-options">
<c:forEach var="producer" items="${requestScope.producersList}">
<div class="multi-select-option" data-value="${producer.producer_id}" data-text="${producer.name}">
<input type="checkbox" id="producer${producer.producer_id}">
<label for="producer${producer.producer_id}">${producer.name}</label>
</div>
</c:forEach>
</div>
</div>
<div class="selected-tags" id="selectedProducers"></div>
<!-- Hidden inputs for selected producers -->
<div id="producerHiddenInputs"></div>
</div>
</div>

<!-- Poster Upload/URL -->
<div class="form-group">
<label class="form-label">
<i class="fas fa-image"></i> Poster
</label>
<div class="upload-container">
<div class="upload-options">
<div class="upload-option active" data-type="file" data-target="poster">
<i class="fas fa-upload"></i> Upload File
</div>
</div>
<div id="posterFileInput">
<div class="file-upload-area">
<input type="file" name="posterFile" class="file-input"
accept="image/*" id="posterFileUpload">
<div class="file-upload-content">
<i class="fas fa-image file-upload-icon"></i>
<div class="file-upload-text">Click to select poster image</div>
<div class="file-upload-subtext">or drag and drop (PNG, JPG, JPEG)</div>
</div>
</div>
<div class="file-preview" id="posterFilePreview">
<i class="fas fa-image file-preview-icon"></i>
<span class="file-preview-name"></span>
<button type="button" class="file-preview-remove">Remove</button>
</div>
</div>
</div>
</div>

<!-- Trailer Upload/URL -->
<div class="form-group">
<label class="form-label">
<i class="fas fa-play-circle"></i> Trailer
</label>
<div class="upload-container">
<div class="upload-options">
<div class="upload-option active" data-type="file" data-target="trailer">
<i class="fas fa-upload"></i> Upload File
</div>
</div>
<div id="trailerFileInput">
<div class="file-upload-area">
<input type="file" name="trailerFile" class="file-input"
accept="video/*" id="trailerFileUpload">
<div class="file-upload-content">
<i class="fas fa-video file-upload-icon"></i>
<div class="file-upload-text">Click to select trailer video</div>
<div class="file-upload-subtext">or drag and drop (MP4, AVI, MOV)</div>
</div>
</div>
<div class="file-preview" id="trailerFilePreview">
<i class="fas fa-video file-preview-icon"></i>
<span class="file-preview-name"></span>
<button type="button" class="file-preview-remove">Remove</button>
</div>
</div>
</div>
</div>

<div class="form-group full-width">
<label for="description" class="form-label">
<i class="fas fa-align-left"></i> Mô tả *
</label>
<textarea id="description" name="description" class="form-textarea"
placeholder="Nhập mô tả chi tiết về phim..." required></textarea>
</div>
</div>

<div class="preview-section" id="previewSection" style="display: none;">
<div class="preview-title">
<i class="fas fa-eye"></i>
Preview
</div>
<div class="preview-content">
<div class="poster-preview" id="posterPreview">
<i class="fas fa-image"></i>
<span>Poster Preview</span>
<div class="poster-error">
<i class="fas fa-exclamation-triangle"></i>
<span>Failed to load image.</span>
</div>
</div>
<div class="movie-info">
<div class="info-item">
<span class="info-label">Tên phim:</span>
<span class="info-value" id="previewName">-</span>
</div>
<div class="info-item">
<span class="info-label">Thời lượng:</span>
<span class="info-value" id="previewDuration">-</span>
</div>
<div class="info-item">
<span class="info-label">Giới hạn tuổi:</span>
<span class="info-value" id="previewAge">-</span>
</div>
<div class="info-item">
<span class="info-label">Thể loại:</span>
<span class="info-value" id="previewGenre">-</span>
</div>
<div class="info-item">
<span class="info-label">Nhà sản xuất:</span>
<span class="info-value" id="previewProducer">-</span>
</div>
<div class="info-item">
<span class="info-label">Mô tả:</span>
<span class="info-value" id="previewDescription">-</span>
</div>
</div>
</div>
</div>

<div class="button-group">
<button type="submit" class="btn btn-primary">
<i class="fas fa-plus"></i>
Thêm phim
</button>
<button type="reset" class="btn btn-secondary">
<i class="fas fa-undo"></i>
Reset
</button>
</div>
</form>
</div>
</div>

<script>
// Multi-select functionality
class MultiSelect {
constructor(dropdownId, tagsContainerId, hiddenInputsId, name) {
this.dropdown = document.getElementById(dropdownId);
this.tagsContainer = document.getElementById(tagsContainerId);
this.hiddenInputsContainer = document.getElementById(hiddenInputsId);
this.name = name;
this.selectedItems = new Map();
this.init();
}
init() {
var self = this;
// Toggle dropdown
this.dropdown.querySelector('.multi-select-display').addEventListener('click', function() {
self.dropdown.classList.toggle('open');
});
// Close dropdown when clicking outside
document.addEventListener('click', function(e) {
if (!self.dropdown.contains(e.target)) {
self.dropdown.classList.remove('open');
}
});
// Handle option selection
this.dropdown.querySelectorAll('.multi-select-option').forEach(function(option) {
option.addEventListener('click', function(e) {
e.stopPropagation();
self.toggleOption(option);
});
// Handle checkbox click
var checkbox = option.querySelector('input[type="checkbox"]');
checkbox.addEventListener('change', function(e) {
e.stopPropagation();
self.toggleOption(option);
});
});
}
toggleOption(option) {
var value = option.dataset.value;
var text = option.dataset.text;
var checkbox = option.querySelector('input[type="checkbox"]');
if (this.selectedItems.has(value)) {
// Remove item
this.selectedItems.delete(value);
option.classList.remove('selected');
checkbox.checked = false;
this.removeTag(value);
this.removeHiddenInput(value);
} else {
// Add item
this.selectedItems.set(value, text);
option.classList.add('selected');
checkbox.checked = true;
this.addTag(value, text);
this.addHiddenInput(value);
}
this.updateDisplay();
updatePreview();
}
addTag(value, text) {
var self = this;
var tag = document.createElement('div');
tag.className = 'tag';
tag.dataset.value = value;
tag.innerHTML = '<span>' + text + '</span><button type="button" class="tag-remove" onclick="' +
(this.name === 'genreIds[]' ? 'multiSelectGenre' : 'multiSelectProducer') +
'.removeItem(\'' + value + '\')"><i class="fas fa-times"></i></button>';
this.tagsContainer.appendChild(tag);
}
removeTag(value) {
var tag = this.tagsContainer.querySelector('[data-value="' + value + '"]');
if (tag) {
tag.remove();
}
}
addHiddenInput(value) {
var input = document.createElement('input');
input.type = 'hidden';
input.name = this.name;
input.value = value;
input.dataset.value = value;
this.hiddenInputsContainer.appendChild(input);
}
removeHiddenInput(value) {
var input = this.hiddenInputsContainer.querySelector('[data-value="' + value + '"]');
if (input) {
input.remove();
}
}
removeItem(value) {
var option = this.dropdown.querySelector('[data-value="' + value + '"]');
if (option) {
this.toggleOption(option);
}
}
updateDisplay() {
var display = this.dropdown.querySelector('.multi-select-display span');
if (this.selectedItems.size === 0) {
display.textContent = this.name === 'genreIds[]' ? 'Chọn thể loại' : 'Chọn nhà sản xuất';
display.className = 'multi-select-placeholder';
} else {
display.textContent = 'Đã chọn ' + this.selectedItems.size + ' mục';
display.className = '';
}
}
reset() {
var self = this;
this.selectedItems.clear();
this.tagsContainer.innerHTML = '';
this.hiddenInputsContainer.innerHTML = '';
this.dropdown.querySelectorAll('.multi-select-option').forEach(function(option) {
option.classList.remove('selected');
option.querySelector('input[type="checkbox"]').checked = false;
});
this.updateDisplay();
}
getSelectedTexts() {
return Array.from(this.selectedItems.values());
}
}

// Initialize multi-selects
var multiSelectGenre = new MultiSelect('genreDropdown', 'selectedGenres', 'genreHiddenInputs', 'genreIds[]');
var multiSelectProducer = new MultiSelect('producerDropdown', 'selectedProducers', 'producerHiddenInputs', 'producerIds[]');

// No upload option switching needed, only file upload is available
// Ensure file input is always visible
document.getElementById('posterFileInput').style.display = 'block';
document.getElementById('trailerFileInput').style.display = 'block';

// File upload handling
function setupFileUpload(inputId, previewId) {
var fileInput = document.getElementById(inputId);
var filePreview = document.getElementById(previewId);
var uploadArea = fileInput.parentElement;
fileInput.addEventListener('change', function() {
var file = this.files[0];
if (file) {
filePreview.querySelector('.file-preview-name').textContent = file.name;
filePreview.classList.add('show');
updatePreview();
}
});
filePreview.querySelector('.file-preview-remove').addEventListener('click', function() {
fileInput.value = '';
filePreview.classList.remove('show');
updatePreview();
});
// Drag and drop
uploadArea.addEventListener('dragover', function(e) {
e.preventDefault();
this.classList.add('dragover');
});
uploadArea.addEventListener('dragleave', function(e) {
e.preventDefault();
this.classList.remove('dragover');
});
uploadArea.addEventListener('drop', function(e) {
e.preventDefault();
this.classList.remove('dragover');
var files = e.dataTransfer.files;
if (files.length > 0) {
fileInput.files = files;
var file = files[0];
filePreview.querySelector('.file-preview-name').textContent = file.name;
filePreview.classList.add('show');
updatePreview();
}
});
}

setupFileUpload('posterFileUpload', 'posterFilePreview');
setupFileUpload('trailerFileUpload', 'trailerFilePreview');

// Preview functionality
var form = document.getElementById('addMovieForm');
var previewSection = document.getElementById('previewSection');
var inputs = form.querySelectorAll('input, select, textarea');

function updatePreview() {
var movieName = document.getElementById('movieName').value;
var duration = document.getElementById('duration').value;
var ageLimit = document.getElementById('ageLimit').value;
var description = document.getElementById('description').value;
// Get selected genres and producers
var selectedGenres = multiSelectGenre.getSelectedTexts().join(', ');
var selectedProducers = multiSelectProducer.getSelectedTexts().join(', ');
// Get poster source (file only)
var posterSrc = '';
var posterFileInput = document.getElementById('posterFileUpload');
if (posterFileInput.files && posterFileInput.files[0]) {
posterSrc = URL.createObjectURL(posterFileInput.files[0]);
}
// Show preview if any field has content
var hasContent = movieName || duration || ageLimit || selectedGenres || selectedProducers || description || posterSrc;
previewSection.style.display = hasContent ? 'block' : 'none';
// Update preview content
document.getElementById('previewName').textContent = movieName || '-';
document.getElementById('previewDuration').textContent = duration ? duration + ' phút' : '-';
document.getElementById('previewAge').textContent = ageLimit || '-';
document.getElementById('previewGenre').textContent = selectedGenres || '-';
document.getElementById('previewProducer').textContent = selectedProducers || '-';
document.getElementById('previewDescription').textContent = description || '-';
// Update poster preview
var posterPreview = document.getElementById('posterPreview');
var posterError = posterPreview.querySelector('.poster-error');
if (posterSrc) {
// Clear previous content
posterPreview.innerHTML = '<div class="poster-error" style="display: none;"><i class="fas fa-exclamation-triangle"></i><span>Failed to load image.</span></div>';
// Create new image element
var img = document.createElement('img');
img.src = posterSrc;
img.alt = 'Poster Preview';
// Handle image load success
img.onload = function() {
var errorDiv = posterPreview.querySelector('.poster-error');
if (errorDiv) {
errorDiv.style.display = 'none';
}
};
// Handle image load error
img.onerror = function() {
this.style.display = 'none';
var errorDiv = posterPreview.querySelector('.poster-error');
if (errorDiv) {
errorDiv.style.display = 'flex';
}
};
posterPreview.appendChild(img);
} else {
posterPreview.innerHTML = '<i class="fas fa-image"></i><span>Poster Preview</span>';
}
}

// Add event listeners for real-time preview
inputs.forEach(function(input) {
input.addEventListener('input', updatePreview);
input.addEventListener('change', updatePreview);
});

// Form submission with loading state
form.addEventListener('submit', function() {
document.querySelector('.container').classList.add('loading');
});

// Reset form and preview
form.addEventListener('reset', function() {
setTimeout(function() {
// Reset multi-selects
multiSelectGenre.reset();
multiSelectProducer.reset();
// Ensure file inputs are visible and active
document.querySelectorAll('.upload-option').forEach(function(opt) {
opt.classList.remove('active');
});
document.querySelectorAll('.upload-option[data-type="file"]').forEach(function(opt) {
opt.classList.add('active');
});
document.getElementById('posterFileInput').style.display = 'block';
document.getElementById('trailerFileInput').style.display = 'block';
// Hide file previews
document.querySelectorAll('.file-preview').forEach(function(preview) {
preview.classList.remove('show');
});
updatePreview();
}, 10);
});
</script>
</body>
</html>
