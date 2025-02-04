Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AE920DD79
	for <fstests@vger.kernel.org>; Tue,  4 Feb 2025 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738673527; cv=none; b=MyegWVPcGyOnxDvhLEj8BTWB7afdb6w0cpz50uTTyPRYCuxMLS7RbXTi6UDgZ8M3SCEwrVdEXSge4RRaMcpUYKjbHvfDFLnPqejdimy/DysRB9zWpGK5SU7ZtE7yOguJ+R2On4L4CeRXBDOmrwaEdPgeC6dN104bK9BFj1ZedlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738673527; c=relaxed/simple;
	bh=8n0K3oEXjpUQSIn13J0frJ3EeDfDvpiPjNGUzmzsAFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZP3bsc4gsFCfku5beUE0Vd3EpruNLgCS8NPX7Pc0TL09KZMwMlDSf5kHiov0F4OxU0mtJ+YzHmjfOgKrBWgXFEk1T+czvGAriv0xn0F+QxJfrGXT0Y186YwaVwPrOXaf99Xcf1SR5jlwkU5iud9Unds1uvgVHID75Sz2ozCfmLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeUGE6Oq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeUGE6Oq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F66C4CEEA;
	Tue,  4 Feb 2025 12:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738673527;
	bh=8n0K3oEXjpUQSIn13J0frJ3EeDfDvpiPjNGUzmzsAFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WeUGE6Oqt+vs1xYeKjciOiT3ZMPa1aXE0QeUzY/ihyI9vfBg9dodQYsTvzLNm6Znj
	 fwT8aGhoBgfCYoiY9+u0WUT9J1GYaph8RuXPtzqsJuOcTNjK7cbcvDOf/3Dyxo7DS2
	 nIy358xn8/xSYt+TPN6XAWUMeyX3rMlpFQdCQfq2zn43AptybaC6qzw7IfLq1pHKy+
	 s7Bc5frq6kg6RQRFDoRo9L7liA9uROTwo2QQTurbmDlTvAS3ERNOSLiaJeQl54aR7C
	 UKvbiSLCsZ59OTpnst8Vhxru/8xr5llbeRjiWFOVOFKZ3lzOSi6t9Gx4aE/Nafrk5n
	 TTSMIdKbgswMw==
Date: Tue, 4 Feb 2025 13:52:03 +0100
From: Christian Brauner <brauner@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] fix vfs/utils.c for big-endian systems
Message-ID: <20250204-plexiglas-pinkfarben-cf6e7b332313@brauner>
References: <fb7ad928-bbe9-4488-a6b7-a2786782bccd@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb7ad928-bbe9-4488-a6b7-a2786782bccd@redhat.com>

On Mon, Jan 27, 2025 at 03:43:24PM -0600, Eric Sandeen wrote:
> generic/633 was failing with EINVAL on the fsxgetattr call on s390.
> Looks like this is due to a failure to properly endian swap the
> arguments to the syscall, so fix that, and the magic_etc compare
> in expected_dummy_vfs_caps_uid() as well while we're at it.
> 
> Fixes: 0d1af68e ("generic: add fstests for idmapped mounts")
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>
