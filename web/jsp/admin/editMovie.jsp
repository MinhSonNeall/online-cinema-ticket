<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Movie - Admin Dashboard</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/editMovieStyle.css">
    </head>
    <body>
        <div class="container">
            <div class="header">
                <div class="header-content">
                    <h1>Edit Movie</h1>
                    <p>Update movie details for "${requestScope.movie.title}"</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin/ManageMovie" class="back-btn">
                    <i class="fas fa-arrow-left"></i>
                    Back to Movies
                </a>
            </div>

            <div class="form-container">
                <c:if test="${not empty requestScope.error}">
                    <div class="message error">
                        <i class="fas fa-exclamation-circle"></i>
                        ${requestScope.error}
                    </div>
                </c:if>

                <c:if test="${not empty requestScope.success}">
                    <div class="message success">
                        <i class="fas fa-check-circle"></i>
                        ${requestScope.success}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/ManageMovie" method="post" enctype="multipart/form-data" id="editMovieForm">
                    <input type="hidden" name="service" value="updateMovie">
                    <input type="hidden" name="movieId" value="${requestScope.movie.movie_id}">
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="movieName" class="form-label"><i class="fas fa-film"></i> Movie Title *</label>
                            <input type="text" id="movieName" name="movieName" class="form-input" placeholder="Enter movie title" required value="${requestScope.movie.title}">
                        </div>

                        <div class="form-group">
                            <label for="duration" class="form-label"><i class="fas fa-clock"></i> Duration (minutes) *</label>
                            <input type="number" id="duration" name="duration" class="form-input" placeholder="120" min="1" max="500" required value="${requestScope.movie.duration}">
                        </div>

                        <div class="form-group">
                            <label for="director" class="form-label"><i class="fas fa-user-tie"></i> Director *</label>
                            <input type="text" id="director" name="director" class="form-input" placeholder="Enter director's name" required value="${requestScope.movie.director}">
                        </div>

                        <div class="form-group">
                            <label for="releaseDate" class="form-label"><i class="fas fa-calendar-alt"></i> Release Date *</label>
                            <input type="date" id="releaseDate" name="releaseDate" class="form-input" required value="${requestScope.movie.release_date}">
                        </div>
                        
                        <div class="form-group">
                            <label for="ageLimit" class="form-label"><i class="fas fa-user-shield"></i> Age Restriction *</label>
                            <select id="ageLimit" name="ageLimit" class="form-select" required>
                                <option value="" disabled>Select age restriction</option>
                                <option value="0" ${requestScope.movie.age_restriction == 0 ? 'selected' : ''}>P - Suitable for all ages</option>
                                <option value="13" ${requestScope.movie.age_restriction == 13 ? 'selected' : ''}>T13 - 13+ rated</option>
                                <option value="16" ${requestScope.movie.age_restriction == 16 ? 'selected' : ''}>T16 - 16+ rated</option>
                                <option value="18" ${requestScope.movie.age_restriction == 18 ? 'selected' : ''}>T18 - 18+ rated</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="status" class="form-label"><i class="fas fa-info-circle"></i> Status *</label>
                            <select id="status" name="status" class="form-select" required>
                                <option value="" disabled>Select status</option>
                                <option value="COMING_SOON" ${requestScope.movie.status.name() == 'COMING_SOON' ? 'selected' : ''}>Coming Soon</option>
                                <option value="NOW_SHOWING" ${requestScope.movie.status.name() == 'NOW_SHOWING' ? 'selected' : ''}>Now Showing</option>
                                <option value="STOP_SHOWING" ${requestScope.movie.status.name() == 'STOP_SHOWING' ? 'selected' : ''}>Stop Showing</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label class="form-label"><i class="fas fa-tags"></i> Genres *</label>
                            <div class="multi-select-container">
                                <div class="multi-select-dropdown" id="genreDropdown">
                                    <div class="multi-select-display">
                                        <span class="multi-select-placeholder">Select genres</span>
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
                                <div id="genreHiddenInputs"></div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label"><i class="fas fa-building"></i> Producers *</label>
                            <div class="multi-select-container">
                                <div class="multi-select-dropdown" id="producerDropdown">
                                    <div class="multi-select-display">
                                        <span class="multi-select-placeholder">Select producers</span>
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
                                <div id="producerHiddenInputs"></div>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label"><i class="fas fa-image"></i> Poster</label>
                            <div class="current-file">
                                <img src="${pageContext.request.contextPath}${requestScope.movie.poster_url}" alt="Current Poster">
                                <span>Current: ${requestScope.movie.poster_url}</span>
                            </div>
                            <div class="file-upload-area">
                                <input type="file" name="posterFile" class="file-input" accept="image/*" id="posterFileUpload">
                                <div class="file-upload-content">
                                    <i class="fas fa-upload file-upload-icon"></i>
                                    <div class="file-upload-text">Change poster image</div>
                                    <div class="file-upload-subtext">Drag and drop or click to select</div>
                                </div>
                            </div>
                            <div class="file-preview" id="posterFilePreview">
                                <i class="fas fa-image file-preview-icon"></i>
                                <span class="file-preview-name"></span>
                                <button type="button" class="file-preview-remove">Remove</button>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label"><i class="fas fa-video"></i> Trailer</label>
                             <div class="current-file">
                                <span>Current: ${requestScope.movie.trailer_url}</span>
                            </div>
                            <div class="file-upload-area">
                                <input type="file" name="trailerFile" class="file-input" accept="video/*" id="trailerFileUpload">
                                <div class="file-upload-content">
                                    <i class="fas fa-upload file-upload-icon"></i>
                                    <div class="file-upload-text">Change trailer video</div>
                                    <div class="file-upload-subtext">Drag and drop or click to select</div>
                                </div>
                            </div>
                            <div class="file-preview" id="trailerFilePreview">
                                <i class="fas fa-video file-preview-icon"></i>
                                <span class="file-preview-name"></span>
                                <button type="button" class="file-preview-remove">Remove</button>
                            </div>
                        </div>

                        <div class="form-group full-width">
                            <label for="description" class="form-label"><i class="fas fa-align-left"></i> Description *</label>
                            <textarea id="description" name="description" class="form-textarea" placeholder="Enter detailed movie description..." required>${requestScope.movie.description}</textarea>
                        </div>
                    </div>

                    <div class="button-group">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i>
                            Save Changes
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/ManageMovie" class="btn btn-secondary">
                            <i class="fas fa-times"></i>
                            Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <script>
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
                    const self = this;
                    this.dropdown.querySelector('.multi-select-display').addEventListener('click', () => {
                        this.dropdown.classList.toggle('open');
                    });

                    document.addEventListener('click', (e) => {
                        if (!this.dropdown.contains(e.target)) {
                            this.dropdown.classList.remove('open');
                        }
                    });

                    this.dropdown.querySelectorAll('.multi-select-option').forEach(option => {
                        option.addEventListener('click', (e) => {
                            e.stopPropagation();
                            this.toggleOption(option);
                        });
                         option.querySelector('input[type="checkbox"]').addEventListener('change', (e) => {
                             e.stopPropagation();
                            this.toggleOption(option);
                        });
                    });
                }

                toggleOption(option) {
                    const value = option.dataset.value;
                    const text = option.dataset.text;
                    const checkbox = option.querySelector('input[type="checkbox"]');
                    if (this.selectedItems.has(value)) {
                        this.selectedItems.delete(value);
                        option.classList.remove('selected');
                        checkbox.checked = false;
                        this.removeTag(value);
                        this.removeHiddenInput(value);
                    } else {
                        this.selectedItems.set(value, text);
                        option.classList.add('selected');
                        checkbox.checked = true;
                        this.addTag(value, text);
                        this.addHiddenInput(value);
                    }
                    this.updateDisplay();
                }

                addTag(value, text) {
                    const tag = document.createElement('div');
                    tag.className = 'tag';
                    tag.dataset.value = value;
                    tag.innerHTML = `<span>\${text}</span><button type="button" class="tag-remove">&times;</button>`;
                    tag.querySelector('.tag-remove').addEventListener('click', () => this.removeItem(value));
                    this.tagsContainer.appendChild(tag);
                }

                removeTag(value) {
                    const tag = this.tagsContainer.querySelector(`[data-value="\${value}"]`);
                    if (tag) tag.remove();
                }
                
                addHiddenInput(value) {
                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = this.name;
                    input.value = value;
                    input.dataset.value = value;
                    this.hiddenInputsContainer.appendChild(input);
                }

                removeHiddenInput(value) {
                    const input = this.hiddenInputsContainer.querySelector(`[data-value="\${value}"]`);
                    if (input) input.remove();
                }
                
                removeItem(value) {
                    const option = this.dropdown.querySelector(`[data-value="\${value}"]`);
                    if (option) this.toggleOption(option);
                }

                updateDisplay() {
                    const display = this.dropdown.querySelector('.multi-select-display span');
                    if (this.selectedItems.size === 0) {
                        display.textContent = `Select \${this.name === 'genreIds[]' ? 'genres' : 'producers'}`;
                        display.classList.add('multi-select-placeholder');
                    } else {
                        display.textContent = `\${this.selectedItems.size} selected`;
                        display.classList.remove('multi-select-placeholder');
                    }
                }
                
                selectItems(ids) {
                    ids.forEach(id => {
                        const option = this.dropdown.querySelector(`[data-value="\${id}"]`);
                        if(option && !this.selectedItems.has(id.toString())) {
                           this.toggleOption(option);
                        }
                    });
                }
            }

            const multiSelectGenre = new MultiSelect('genreDropdown', 'selectedGenres', 'genreHiddenInputs', 'genreIds[]');
            const multiSelectProducer = new MultiSelect('producerDropdown', 'selectedProducers', 'producerHiddenInputs', 'producerIds[]');
            
            // Pre-select genres and producers
            document.addEventListener('DOMContentLoaded', function() {
                const selectedGenreIds = [<c:forEach var="g" items="${requestScope.movieGenres}" varStatus="loop">${g.genre_id}${!loop.last ? ',' : ''}</c:forEach>];
                const selectedProducerIds = [<c:forEach var="p" items="${requestScope.movieProducers}" varStatus="loop">${p.producer_id}${!loop.last ? ',' : ''}</c:forEach>];
                
                multiSelectGenre.selectItems(selectedGenreIds.map(String));
                multiSelectProducer.selectItems(selectedProducerIds.map(String));
            });


            function setupFileUpload(inputId, previewId) {
                const fileInput = document.getElementById(inputId);
                const filePreview = document.getElementById(previewId);
                const uploadArea = fileInput.closest('.file-upload-area');

                fileInput.addEventListener('change', function () {
                    if (this.files[0]) {
                        filePreview.querySelector('.file-preview-name').textContent = this.files[0].name;
                        filePreview.classList.add('show');
                    }
                });

                filePreview.querySelector('.file-preview-remove').addEventListener('click', function () {
                    fileInput.value = '';
                    filePreview.classList.remove('show');
                });
                
                uploadArea.addEventListener('dragover', e => e.preventDefault());
                uploadArea.addEventListener('drop', e => {
                    e.preventDefault();
                    fileInput.files = e.dataTransfer.files;
                    const event = new Event('change');
                    fileInput.dispatchEvent(event);
                });
            }

            setupFileUpload('posterFileUpload', 'posterFilePreview');
            setupFileUpload('trailerFileUpload', 'trailerFilePreview');

        </script>
    </body>
</html>
