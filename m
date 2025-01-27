Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A731DA4E
	for <fstests@vger.kernel.org>; Mon, 27 Jan 2025 21:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738014875; cv=none; b=RMsGydelUdVqHhbfqMOVgsSxxgtd8XBm/oad7puG7y8Vqq2FK49eFVdIzmwEv/c3BZiqBhuUYn+e4fYxiGcNiq711AI1zW2aHqztBjgFBmoWOi1S5noLcQ22iD/pm4Gfm6WH5wzsD0bPyiWZ01fFsaCRZZ6lA309KznGmgN3I1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738014875; c=relaxed/simple;
	bh=drL44fyGvXrBU5YjU9LvyEXjB3devY7mGlnR3KIOg54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcCPE619eNAzu4+JngIR1rM01nTahow4rnjHTIhKsxG5hRpKTWAaPbrYr6fO/pYmizrAL+pRVOw5Gz/31nVzMcoePytCJcHOjnkRkRRIlfXSXYITF81fN+Bu78vVKyzs3VRx2H1dh/4HcLO8TaasfFt/hW7RH8NzQbJ2rWMBEEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6nthGAP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6nthGAP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9137C4CED2;
	Mon, 27 Jan 2025 21:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738014874;
	bh=drL44fyGvXrBU5YjU9LvyEXjB3devY7mGlnR3KIOg54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o6nthGAPuFqk20lq8buUr9UAhxYvD9+ioJPbPwtjh5Lb1be6ScRPJ8BJo6XjUSBaD
	 Lg52OwaALWRjN4jokd/wjS8YElKmWYXmyUTuiN6Sl4WIrEwHdcZiYOP1TXXWilYBW/
	 EDYO0PLYABR8SbHNuS4d2G12h4srL6FNPQmuKP+d2NyOM3AmwtRcXaF7Ovm9ALpUFi
	 WWlp1ZGkq8Qknpq9Wpi02xEtNpgmulY8ZevnU3H3HGSLe3Vgt+8xvru4hSaoXKSHor
	 lBnfu1qeLHLieIvZXmGs+PSCqcJai0F9USlbc1DKyCzOIg/ICm8hYRoc5ft0LYk6Ub
	 UsGye1p4LuaVQ==
Date: Mon, 27 Jan 2025 13:54:34 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] fix vfs/utils.c for big-endian systems
Message-ID: <20250127215434.GO3557695@frogsfrogsfrogs>
References: <fb7ad928-bbe9-4488-a6b7-a2786782bccd@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb7ad928-bbe9-4488-a6b7-a2786782bccd@redhat.com>

On Mon, Jan 27, 2025 at 03:43:24PM -0600, Eric Sandeen wrote:
> generic/633 was failing with EINVAL on the fsxgetattr call on s390.
> Looks like this is due to a failure to properly endian swap the
> arguments to the syscall, so fix that, and the magic_etc compare
> in expected_dummy_vfs_caps_uid() as well while we're at it.

Hmmm, I see this when running the same test on ext4:

--- /tmp/fstests/tests/generic/633.out  2025-01-16 12:11:43.921449208 -0800
+++ /var/tmp/fstests/generic/633.out.bad        2025-01-27 13:49:27.413943989 -0800
@@ -1,2 +1,4 @@
 QA output created by 633
 Silence is golden
+utils.c: 928: openat_tmpfile_supported - Invalid argument - failure: create
+utils.c: 928: openat_tmpfile_supported - Invalid argument - failure: create

I think this is a separate bug?  And curiously it doesn't trigger on xfs
or btrfs :P

> Fixes: 0d1af68e ("generic: add fstests for idmapped mounts")
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> diff --git a/src/vfs/utils.c b/src/vfs/utils.c
> index c1c7951c..52bb7e42 100644
> --- a/src/vfs/utils.c
> +++ b/src/vfs/utils.c
> @@ -650,7 +650,7 @@ bool expected_dummy_vfs_caps_uid(int fd, uid_t expected_uid)
>  	if (ret < 0 || ret == 0)
>  		return false;
>  
> -	if (ns_xattr.magic_etc & VFS_CAP_REVISION_3) {
> +	if (le32_to_cpu(ns_xattr.magic_etc) & VFS_CAP_REVISION_3) {
>  
>  		if (le32_to_cpu(ns_xattr.rootid) != expected_uid) {
>  			errno = EINVAL;
> @@ -673,10 +673,12 @@ int set_dummy_vfs_caps(int fd, int flags, int rootuid)
>  	ns_cap_data.data[(x) >> 5].permitted |= (1 << ((x)&31))
>  
>  	struct vfs_ns_cap_data ns_xattr;
> +	__le32 magic_etc;
>  
>  	memset(&ns_xattr, 0, sizeof(ns_xattr));
>  	__raise_cap_permitted(CAP_NET_RAW, ns_xattr);
> -	ns_xattr.magic_etc |= VFS_CAP_REVISION_3 | VFS_CAP_FLAGS_EFFECTIVE;
> +	magic_etc = (VFS_CAP_REVISION_3 | VFS_CAP_FLAGS_EFFECTIVE);
> +	ns_xattr.magic_etc |= cpu_to_le32(magic_etc);

Not sure why you wouldn't just pass (VFS_CAP_REVISION_3 |
VFS_CAP_FLAGS_EFFECTIVE) directly to cpu_to_le32 but it doesn't matter.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  	ns_xattr.rootid = cpu_to_le32(rootuid);
>  
>  	return fsetxattr(fd, "security.capability",
> 
> 
