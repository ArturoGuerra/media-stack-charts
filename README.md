# Media Stack Helm Charts

A collection of Helm charts for a personal media stack, built with a shared `common` library chart for consistency.

## Available Charts

### Media Servers & Players
- **[jellyfin](jellyfin/)**: The free software media system.
- **[plexmediaserver](plexmediaserver/)**: Media library and streaming application.
- **[tautulli](tautulli/)**: Monitoring and tracking tool for Plex Media Server.

### Media Management (The "Arr" Stack)
- **[bazarr](bazarr/)**: Companion to Sonarr/Radarr for managing subtitles.
- **[lidarr](lidarr/)**: Music collection manager for Usenet and BitTorrent.
- **[prowlarr](prowlarr/)**: Indexer manager and proxy for the arr stack.
- **[radarr](radarr/)**: Movie collection manager for Usenet and BitTorrent.
- **[sonarr](sonarr/)**: TV series collection manager for Usenet and BitTorrent.

### Download Clients & Helpers
- **[qbittorrent](qbittorrent/)**: BitTorrent client with a web UI.
- **[nzbget](nzbget/)**: Efficient Usenet downloader.
- **[unpackerr](unpackerr/)**: Daemon that extracts downloads for Sonarr, Radarr, and Lidarr.
- **[recyclarr](recyclarr/)**: CLI tool to sync TRaSH guides settings.

### Utilities & Maintenance
- **[checkrr](checkrr/)**: Service that checks media files for corruption.
- **[cleanuparr](cleanuparr/)**: Automated cleanup tool for Sonarr and Radarr queues.
- **[maintainerr](maintainerr/)**: Tool for managing and cleaning up media libraries.
- **[scraparr](scraparr/)**: Tool for scraping media metadata tags.

### Request & User Management
- **[doplarr](doplarr/)**: Discord bot for requesting media via Overseerr or Sonarr/Radarr.
- **[membarr](membarr/)**: Discord bot for inviting users to Plex or Jellyfin.
- **[requestrr](requestrr/)**: Discord chatbot for requesting media.
- **[wizarr](wizarr/)**: User invitation and management system for Plex and Jellyfin.

### Dashboard & UI
- **[qui](qui/)**: Web dashboard for autobrr metrics and status.
- **[tdarr](tdarr/)**: Distributed video transcoding and health-checking system.

### Shared
- **[common](common/)**: Library chart providing shared templates and helpers.

## Prerequisites

- Helm 3.0+
- Kubernetes 1.16+
- A configured `kubectl` context

## Usage

### Local Development
```bash
# Build dependencies
make deps

# Lint all charts
make lint

# Generate templates
make template
```

## Configuration

Each chart has a `values.yaml` file with various configuration options. See the individual chart READMEs for more details.

## License

MIT
