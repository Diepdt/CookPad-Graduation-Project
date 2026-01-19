/** @type {import('next').NextConfig} */
const nextConfig = {
  experimental: {
    optimizePackageImports: ['swiper', 'iconsax-reactjs'],
  },
  eslint: {
    ignoreDuringBuilds: true,
  },
  typescript: {
    ignoreBuildErrors: true,
  },
  turbopack: {},

  webpack: (config, { dev, isServer }) => {
    // chỉ show log error, không show warnings
    config.infrastructureLogging = { level: "error" };

    if (process.platform === 'win32') {
      config.watchOptions = {
        poll: 1000,
        aggregateTimeout: 300,
        ignored: /node_modules/,
      };
    }

    config.module.rules.push({
      test: /flag-icons.*\.css$/,
      type: "asset/resource",
    });

    return config;
  },

  images: {
    qualities: [25, 50, 75, 100],
    remotePatterns: [
      { protocol: "http", hostname: "127.0.0.1", port: "8080", pathname: "/**" },
      { protocol: "http", hostname: "localhost", port: "8080", pathname: "/**" },
      { protocol: "https", hostname: "**" },
      { protocol: "https", hostname: "picsum.photos" },
    ],
  },

  // 🔹 thêm phần này để tắt overlay cảnh báo dev (chỉ lỗi mới hiện)
  devIndicators: {
    buildActivity: false,
  },
};

export default nextConfig;
