Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95E13590A9;
	Fri, 19 Jun 2026 08:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781857267; cv=none; b=U3/qseMEE/JVpUjLfLOIr62fJQYSZC6AG2XdhEvVczdzsnxZWNfb2aDVhCIUdmE8KUi1osfkgljLVbB0eHhGHoY8a/wq8to7s2FqLyQ0VFH9o6SYuNvAX6DLpq4eQ426YhUMsjoCzhWekD+TRtViW8MnigPbPPDC+USh2uXLFbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781857267; c=relaxed/simple;
	bh=MMYZ7Tv90XOOpkYGuLomRVP91ZwvEzQNGXTLycz+e5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBY7ZvINtIP4ydr/Ze/6zd34wuzwll7YCVjuYVzQz1YeknvQWJIe4730LlwqGxDcWwP1aJ1Oz3EKQmSWhijHXwH5OF6trNvLGSIfsYVbtTjzmGoVsAcrj6sdCfzk0LQALFToWGnPoTzbYRRH0ZxHgPSsP0Z+j5aVmaboxn3HUXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0R3Y0OV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0R3Y0OV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533911F000E9;
	Fri, 19 Jun 2026 08:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781857266;
	bh=vS719iN1YtvGS4K63HdJhaUr09/hQHxjoBcGi+JpFxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S0R3Y0OVdmT4XSTqIWt4kargo5qOx+eHLYYzcg1rqQHupfNwIWK3Nw9mgI2NWkcbx
	 nS4mSq5MCNUEVZ9KX/ApstH+k5Gj8RFkYuqo2gpDjXGVdwH3mUtGkDCuHFi9647maE
	 mclrQsmtgXMCCVZmNP5+9o3rAgk+M2mqv79NZmquXxCBLJ9bpfPB+2FCGgLtrLb4Tr
	 uZxA6bASejHabaUyknqZmQwXTiU00Q0zWrxi2mbfSrMYbOTTaeWAEyi7zJSiM+AXGJ
	 R8KjsXT00TMoUUeyqAWCIgbg6Rxu00UcQ/YGEN+kTQ7WsdzYkLWqKIyncDhCiufd3G
	 3h7FI9i/LIPQQ==
Date: Fri, 19 Jun 2026 10:21:03 +0200
From: Christian Brauner <brauner@kernel.org>
To: German Maglione <gmaglione@redhat.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	zlang@kernel.org
Subject: Re: [PATCH 0/2] vfstest: fix tcore_acls() cleanup bug and missing
 _require_acls
Message-ID: <20260619-urgestein-ankam-bespannt-bd1b58edd2a8@brauner>
References: <20260618-xfstests-tcore-acls-fixes-v1-0-45a1aec1d99d@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260618-xfstests-tcore-acls-fixes-v1-0-45a1aec1d99d@redhat.com>

On Thu, Jun 18, 2026 at 12:11:52PM +0200, German Maglione wrote:
> Hi,
> 
> Running xfstests over virtiofs I hit failures in generic/633, 644,
> 645, 656 and 696. Two issues in tcore_acls():
> 
> 1) sys_umount2() only runs on the success path. When setfacl fails,
>    the mount is left behind and every test after that fails with
>    EEXIST.
> 
> 2) generic/633 doesn't declare _require_acls, so it fails instead
>    of being skipped on filesystems without ACL support.
> 
> Signed-off-by: German Maglione <gmaglione@redhat.com>
> ---
> German Maglione (2):
>       vfstest: move sys_umount2() to cleanup path in tcore_acls()
>       generic/633: add _require_acls for tcore_acls() ACL dependency
> 
>  src/vfs/idmapped-mounts.c | 5 ++---
>  tests/generic/633         | 1 +
>  2 files changed, 3 insertions(+), 3 deletions(-)
> ---
> base-commit: cac9fe2b8dc3e6dbc0c2383b9e3b4d3c1b9e7dd0
> change-id: 20260618-xfstests-tcore-acls-fixes-6d15a696f652

Thanks!
Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
