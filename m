Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43461F5406
	for <fstests@vger.kernel.org>; Tue,  7 Jan 2025 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736271050; cv=none; b=fbPzO7UduJduRYSvQiQJxPkXrXD3uuot88K5MkN/3JRzy4YEIZGF6cJ31oDA0OcEf6Dpwi2gvw4PyivGJExrgit+OSeXpmAffScDUj1Glv/ML5HWHNlvfcvu7ueRXszdi52l7oZFK+p4EGYItnWrsjsFSnC/fM6NtrnTyGeU8js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736271050; c=relaxed/simple;
	bh=IAYtzFrVDobGWOD/mzvIF8Bh82RKx+tEC+bb//RkFWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfWPRyjWqyfFGTKwuUXzAstN22vUVkRr2SMCA5Kumv35ojFIt9/3Xvx4vcm9ETF2h9ZKtsunfWcq57c8nv6Hy0Bz//wQl7RJidkCHjcRb//DVMZ+rhF80pIvyt8iLadFL25B2AzTsrSpnLb3YQKhZqa8qltX8NO7/uAHo0h1rhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxWRW+Px; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxWRW+Px"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CF4C4CED6;
	Tue,  7 Jan 2025 17:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736271050;
	bh=IAYtzFrVDobGWOD/mzvIF8Bh82RKx+tEC+bb//RkFWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uxWRW+PxFg5OJZjj+A9ZWYURRPxwb77BbE8gnTqFX6leBFSRyZGWd6JK19q5/90TZ
	 xMv21frPbx2MvZPf2gq9PQ3qTFR0OasoU445gXpVjcZj0DVfB67eeZy6rM3e1HapQU
	 56s3j0AHzGepaMO1U+r4hYS4V0rkUcuFVULJ6fBLN6TnJ/9Llh2iSztMN3Wxqs9UhM
	 vG/d+1ipQlXmsel5XGLcNZ1qeRiD0EGchtiGtzB+MZ/hwA+maNb89rR6LhY8dp3TIc
	 ey05gYMh9j4p1wA1h+FDjG0O/wrHp5zRVFY6AUalXfsUjM1/hyRwKASEzY0pYwXM0s
	 bznVihx56vWqA==
Date: Tue, 7 Jan 2025 09:30:49 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] fsstress: add support for RWF_DONTCACHE
Message-ID: <20250107173049.GQ6160@frogsfrogsfrogs>
References: <20250106174919.103199-1-axboe@kernel.dk>
 <20250106174919.103199-2-axboe@kernel.dk>
 <20250107021102.GO6160@frogsfrogsfrogs>
 <32edc8e2-f338-44d3-9070-4be4b5fc99a2@kernel.dk>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32edc8e2-f338-44d3-9070-4be4b5fc99a2@kernel.dk>

On Mon, Jan 06, 2025 at 07:16:17PM -0700, Jens Axboe wrote:
> On 1/6/25 7:11 PM, Darrick J. Wong wrote:
> >> +void
> >> +read_dontcache_f(opnum_t opno, long r)
> >> +{
> >> +	int		e;
> >> +	pathname_t	f;
> >> +	int		fd;
> >> +	int64_t		lr;
> >> +	off64_t		off;
> >> +	struct stat64	stb;
> >> +	int		v;
> >> +	char		st[1024];
> >> +	struct iovec	iov;
> >> +	int flags;
> >> +
> >> +	init_pathname(&f);
> >> +	if (!get_fname(FT_REGFILE, r, &f, NULL, NULL, &v)) {
> >> +		if (v)
> >> +			printf("%d/%lld: read - no filename\n", procid, opno);
> >> +		free_pathname(&f);
> >> +		return;
> >> +	}
> >> +	fd = open_path(&f, O_RDONLY);
> >> +	e = fd < 0 ? errno : 0;
> >> +	check_cwd();
> >> +	if (fd < 0) {
> >> +		if (v)
> >> +			printf("%d/%lld: read - open %s failed %d\n",
> >> +				procid, opno, f.path, e);
> >> +		free_pathname(&f);
> >> +		return;
> >> +	}
> >> +	if (fstat64(fd, &stb) < 0) {
> >> +		if (v)
> >> +			printf("%d/%lld: read - fstat64 %s failed %d\n",
> >> +				procid, opno, f.path, errno);
> >> +		free_pathname(&f);
> >> +		close(fd);
> >> +		return;
> >> +	}
> >> +	inode_info(st, sizeof(st), &stb, v);
> >> +	if (stb.st_size == 0) {
> >> +		if (v)
> >> +			printf("%d/%lld: read - %s%s zero size\n", procid, opno,
> >> +			       f.path, st);
> >> +		free_pathname(&f);
> >> +		close(fd);
> >> +		return;
> >> +	}
> >> +	lr = ((int64_t)random() << 32) + random();
> >> +	off = (off64_t)(lr % stb.st_size);
> >> +	iov.iov_len = (random() % FILELEN_MAX) + 1;
> >> +	iov.iov_base = malloc(iov.iov_len);
> > 
> > Should there be a check for null iov_base after the allocation?
> 
> Nothing else in fsstress seems to bother with malloc() failures, which
> at least on Linux, is probably fair game.

lol ok.

> >> +	flags = have_rwf_dontcache ? RWF_DONTCACHE : 0;
> >> +	e = preadv2(fd, &iov, 1, off, flags) < 0 ? errno : 0;
> >> +	if (have_rwf_dontcache && e == EOPNOTSUPP)
> > 
> > ...and should this set have_rwf_dontcache = 0?
> 
> I don't think so? If we get EOPNOTSUPP and we don't have dontcache, then
> it's a fatal condition. fsstress defaults to it being available, so we
> may very well run into EOPNOTSUPP and then just do a regular read or
> write for that case. We could probably do:
> 
> if (have_rwf_dontcache && e == EOPNOTSUPP) {
> 	have_rwf_dontcache = 0;
> 	e = preadv2(fd, &iov, 1, off, 0) < 0 ? errno : 0;
> }

Yep, that's exactly what I was thinking. :)

--D

> here and on the write side, at least then we won't repeatedly try
> RWF_DONTCACHE if we hit EOPNOTSUPP. But in terms of logic, it should be
> correct as-is.
> 
> -- 
> Jens Axboe
> 
