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
            }

            .poster-preview img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                border-radius: 8px;
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
                <a href="${pageContext.request.contextPath}/jsp/admin/manageMovie.jsp" class="back-btn">
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

                <form action="${pageContext.request.contextPath}/ManageMovieServlet" method="post" enctype="multipart/form-data" id="addMovieForm">
                    <input type="hidden" name="action" value="add">
                    
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
                                <option value="P">P - Phù hợp mọi lứa tuổi</option>
                                <option value="K">K - Dưới 13 tuổi có người lớn đi kèm</option>
                                <option value="T13">T13 - Từ 13 tuổi trở lên</option>
                                <option value="T16">T16 - Từ 16 tuổi trở lên</option>
                                <option value="T18">T18 - Từ 18 tuổi trở lên</option>
                                <option value="C">C - Cấm chiếu</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="genre" class="form-label">
                                <i class="fas fa-tags"></i> Thể loại *
                            </label>
                            <select id="genre" name="genreId" class="form-select" required>
                                <option value="">Chọn thể loại</option>
                                <c:forEach var="genre" items="${genres}">
                                    <option value="${genre.genreId}">${genre.genreName}</option>
                                </c:forEach>
                                <!-- Default options if no genres loaded -->
                                <option value="1">Hành động</option>
                                <option value="2">Hài kịch</option>
                                <option value="3">Kinh dị</option>
                                <option value="4">Lãng mạn</option>
                                <option value="5">Khoa học viễn tưởng</option>
                                <option value="6">Phiêu lưu</option>
                                <option value="7">Hoạt hình</option>
                                <option value="8">Tài liệu</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="producer" class="form-label">
                                <i class="fas fa-building"></i> Nhà sản xuất *
                            </label>
                            <select id="producer" name="producerId" class="form-select" required>
                                <option value="">Chọn nhà sản xuất</option>
                                <c:forEach var="producer" items="${producers}">
                                    <option value="${producer.producerId}">${producer.producerName}</option>
                                </c:forEach>
                                <!-- Default options if no producers loaded -->
                                <option value="1">Marvel Studios</option>
                                <option value="2">Warner Bros</option>
                                <option value="3">Universal Pictures</option>
                                <option value="4">Sony Pictures</option>
                                <option value="5">Paramount Pictures</option>
                                <option value="6">20th Century Studios</option>
                            </select>
                        </div>

                        <!-- Poster Upload/URL -->
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-image"></i> Poster
                            </label>
                            <div class="upload-container">
                                <div class="upload-options">
                                    <div class="upload-option active" data-type="url" data-target="poster">
                                        <i class="fas fa-link"></i> URL
                                    </div>
                                    <div class="upload-option" data-type="file" data-target="poster">
                                        <i class="fas fa-upload"></i> Upload File
                                    </div>
                                </div>
                                
                                <div id="posterUrlInput">
                                    <input type="url" name="posterUrl" class="form-input" 
                                           placeholder="https://example.com/poster.jpg">
                                </div>
                                
                                <div id="posterFileInput" style="display: none;">
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
                                    <div class="upload-option active" data-type="url" data-target="trailer">
                                        <i class="fas fa-link"></i> URL
                                    </div>
                                    <div class="upload-option" data-type="file" data-target="trailer">
                                        <i class="fas fa-upload"></i> Upload File
                                    </div>
                                </div>
                                
                                <div id="trailerUrlInput">
                                    <input type="url" name="trailerUrl" class="form-input" 
                                           placeholder="https://youtube.com/watch?v=...">
                                </div>
                                
                                <div id="trailerFileInput" style="display: none;">
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
            // Upload option switching
            document.querySelectorAll('.upload-option').forEach(option => {
                option.addEventListener('click', function() {
                    const target = this.dataset.target;
                    const type = this.dataset.type;
                    
                    // Remove active class from siblings
                    this.parentElement.querySelectorAll('.upload-option').forEach(opt => {
                        opt.classList.remove('active');
                    });
                    
                    // Add active class to clicked option
                    this.classList.add('active');
                    
                    // Show/hide appropriate input
                    const urlInput = document.getElementById(target + 'UrlInput');
                    const fileInput = document.getElementById(target + 'FileInput');
                    
                    if (type === 'url') {
                        urlInput.style.display = 'block';
                        fileInput.style.display = 'none';
                        // Clear file input
                        fileInput.querySelector('input[type="file"]').value = '';
                        fileInput.querySelector('.file-preview').classList.remove('show');
                    } else {
                        urlInput.style.display = 'none';
                        fileInput.style.display = 'block';
                        // Clear URL input
                        urlInput.querySelector('input').value = '';
                    }
                    
                    updatePreview();
                });
            });

            // File upload handling
            function setupFileUpload(inputId, previewId) {
                const fileInput = document.getElementById(inputId);
                const filePreview = document.getElementById(previewId);
                const uploadArea = fileInput.parentElement;
                
                fileInput.addEventListener('change', function() {
                    const file = this.files[0];
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
                    
                    const files = e.dataTransfer.files;
                    if (files.length > 0) {
                        fileInput.files = files;
                        const file = files[0];
                        filePreview.querySelector('.file-preview-name').textContent = file.name;
                        filePreview.classList.add('show');
                        updatePreview();
                    }
                });
            }

            setupFileUpload('posterFileUpload', 'posterFilePreview');
            setupFileUpload('trailerFileUpload', 'trailerFilePreview');

            // Preview functionality
            const form = document.getElementById('addMovieForm');
            const previewSection = document.getElementById('previewSection');
            const inputs = form.querySelectorAll('input, select, textarea');

            function updatePreview() {
                const movieName = document.getElementById('movieName').value;
                const duration = document.getElementById('duration').value;
                const ageLimit = document.getElementById('ageLimit').value;
                const genre = document.getElementById('genre').selectedOptions[0]?.text || '';
                const producer = document.getElementById('producer').selectedOptions[0]?.text || '';
                const description = document.getElementById('description').value;
                
                // Get poster source (URL or file)
                let posterSrc = '';
                const posterUrlInput = document.querySelector('input[name="posterUrl"]');
                const posterFileInput = document.querySelector('input[name="posterFile"]');
                
                if (posterUrlInput.parentElement.style.display !== 'none' && posterUrlInput.value) {
                    posterSrc = posterUrlInput.value;
                } else if (posterFileInput.files && posterFileInput.files[0]) {
                    posterSrc = URL.createObjectURL(posterFileInput.files[0]);
                }

                // Show preview if any field has content
                const hasContent = movieName || duration || ageLimit || genre || producer || description || posterSrc;
                previewSection.style.display = hasContent ? 'block' : 'none';

                // Update preview content
                document.getElementById('previewName').textContent = movieName || '-';
                document.getElementById('previewDuration').textContent = duration ? duration + ' phút' : '-';
                document.getElementById('previewAge').textContent = ageLimit || '-';
                document.getElementById('previewGenre').textContent = genre || '-';
                document.getElementById('previewProducer').textContent = producer || '-';
                document.getElementById('previewDescription').textContent = description || '-';

                // Update poster preview
                const posterPreview = document.getElementById('posterPreview');
                if (posterSrc) {
                    posterPreview.innerHTML = `<img src="${posterSrc}" alt="Poster Preview" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                             <div style="display:none; flex-direction:column; align-items:center; gap:8px;">
                                                 <i class="fas fa-exclamation-triangle"></i>
                                                 <span>Invalid Image</span>
                                             </div>`;
                } else {
                    posterPreview.innerHTML = `<i class="fas fa-image"></i><span>Poster Preview</span>`;
                }
            }

            // Add event listeners for real-time preview
            inputs.forEach(input => {
                input.addEventListener('input', updatePreview);
                input.addEventListener('change', updatePreview);
            });

            // Form submission with loading state
            form.addEventListener('submit', function() {
                document.querySelector('.container').classList.add('loading');
            });

            // Reset form and preview
            form.addEventListener('reset', function() {
                setTimeout(() => {
                    // Reset upload options to URL
                    document.querySelectorAll('.upload-option').forEach(opt => {
                        opt.classList.remove('active');
                    });
                    document.querySelectorAll('.upload-option[data-type="url"]').forEach(opt => {
                        opt.classList.add('active');
                    });
                    
                    // Show URL inputs, hide file inputs
                    document.getElementById('posterUrlInput').style.display = 'block';
                    document.getElementById('posterFileInput').style.display = 'none';
                    document.getElementById('trailerUrlInput').style.display = 'block';
                    document.getElementById('trailerFileInput').style.display = 'none';
                    
                    // Hide file previews
                    document.querySelectorAll('.file-preview').forEach(preview => {
                        preview.classList.remove('show');
                    });
                    
                    updatePreview();
                }, 10);
            });
        </script>
    </body>
</html>