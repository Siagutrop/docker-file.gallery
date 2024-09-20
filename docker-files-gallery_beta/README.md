# File Gallery Dockerized

This project provides a Dockerized version of File Gallery, a web-based file manager. The Docker image allows you to quickly set up and run File Gallery with custom configurations using environment variables.

## Features
- **Customizable Configuration**: Use a `.env` file to set configuration options.
- **Dynamic Config File**: Generates a `config.php` file based on environment variables.
- **Ready-to-use Docker Image**: Build and run with a single command.

## Prerequisites
- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/siagutrop/file-gallery-docker.git
    cd file-gallery-docker
    ```

2. Create a `.env` file based on the `.env.example` provided:
    ```bash
    cp .env.example .env
    ```

3. Edit the `.env` file with your desired configurations. Each option is explained in detail below.

4. Build and run the Docker image using Docker Compose:
    ```bash
    docker-compose up --build
    ```

5. Open your browser and go to `http://localhost:8080` (or your specified port) to access File Gallery.

## Configuration

All configuration options can be set using the `.env` file. Below is a detailed explanation of each variable based on the official [File Gallery Configuration Documentation](https://www.files.gallery/docs/config/).

### Disabling Options
To disable an option, simply remove or comment it out in the `.env` file. The script will then use the default setting defined in the `file-start.sh` script or `config.php`.

### General Settings
- **`ROOT`**: The root directory path for the gallery. Leave it empty for the default.
- **`START_PATH`**: Initial folder path within the root. Set to `false` for the root directory.
- **`USERNAME`**: Admin username for accessing the gallery.
- **`PASSWORD`**: Hashed password for admin authentication. You can generate this with tools like bcrypt.

### Image Settings
- **`LOAD_IMAGES`**: Enable or disable image loading. Set to `false` to disable image previews.
- **`LOAD_FILES_PROXY_PHP`**: Use PHP to proxy file loading, useful for controlling permissions.
- **`LOAD_IMAGES_MAX_FILESIZE`**: Maximum file size for image loading, specified in bytes.

### Image Resize Settings
- **`IMAGE_RESIZE_ENABLED`**: Enable or disable image resizing.
- **`IMAGE_RESIZE_CACHE`**: Enable caching of resized images for faster load times.
- **`IMAGE_RESIZE_DIMENSIONS`**: Default width in pixels for resized images.
- **`IMAGE_RESIZE_DIMENSIONS_RETINA`**: Width in pixels for high-DPI displays.
- **`IMAGE_RESIZE_TYPES`**: Allowed image types for resizing.
- **`IMAGE_RESIZE_QUALITY`**: Quality for resized images (0-100).

### Folder Preview
- **`FOLDER_PREVIEW_IMAGE`**: Show a preview image for folders.
- **`FOLDER_PREVIEW_DEFAULT`**: Default image used for folder previews.

### Menu Settings
- **`MENU_ENABLED`**: Enable folder menu in the gallery.
- **`MENU_SHOW`**: Show the folder menu by default if set to `true`.
- **`MENU_MAX_DEPTH`**: Maximum depth of the folder menu display.
- **`MENU_SORT`**: Sorting method for the menu (e.g., name_asc, date_desc).

### Download and Upload Settings
- **`ALLOW_UPLOAD`**: Enable file uploads.
- **`ALLOW_DELETE`**: Allow file deletions.
- **`UPLOAD_MAX_FILESIZE`**: Maximum file size allowed for uploads.

### Example `.env`
```env
# General Settings
USERNAME='admin'
PASSWORD='your_password_hash'

# Image Settings
LOAD_IMAGES=true
IMAGE_RESIZE_ENABLED=true

# Permissions
ALLOW_UPLOAD=true
ALLOW_DELETE=true

# Language
LANG_DEFAULT='en'
TIMEZONE='Europe/Paris'
Building the Docker Image Manually
If you want to build the Docker image manually, run the following command:
```
Building the Docker Image Manually
If you want to build the Docker image manually, run the following command:

```bash
docker build -t siagutrop/file-gallery .
```
Running the Container
To run the container manually without Docker Compose, use:

```bash
docker run -d --name file-gallery -p 8080:80 --env-file .env siagutrop/file-gallery
```
Documentation
For more details on each configuration option, please refer to [the File Gallery Configuration Documentation](https://www.files.gallery/docs/config/).

Contributing
Feel free to fork the project, create a feature branch, and submit a pull request. All contributions are welcome!

### Ajouts :
- **Explication sur la désactivation des options** : Comment enlever ou commenter les variables dans le `.env`.
- **Liste de variables** avec des descriptions détaillées pour chaque section, permettant une personnalisation facile.
