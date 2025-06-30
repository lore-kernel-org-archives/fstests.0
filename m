Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACBC2E41E
	for <fstests@vger.kernel.org>; Mon, 30 Jun 2025 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297338; cv=none; b=K13Zo3CADWsjtAQnH1Orp3p3uTOPEgI4vqRX7TZadyIP9aM2qwGHI9q+Xmvj+rifS8euz3DROXOsyYfo6BQ4gmI3JBjUJlkD0SIH5RDPQ0ycsQeDLmg9LQOwht/T55ezoWtVjlQ57qbcwUvQ4X8UWN8Zvt9ec+ZRrhmumZccieo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297338; c=relaxed/simple;
	bh=+Gfask0StiWLlUCch117SuXIw8xsNI8oykJKkmQ2wAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sqo1WyysOLgzRVakLz1eRDkSiuVPTJbox7c1BwOtNz1qcJqUjAWO3s8mAZqqK4/liB0kml+9IxSpMND3rmELk1YEh4L/wpPvodstWJem2s3YUNaTha2N1eFv3uvlB8jvS1GESg1l8k9akddMRUVRlbd0uZoZp4pXMKPJAZ/lUSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJEzXRaW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJEzXRaW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DEDC4CEE3;
	Mon, 30 Jun 2025 15:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751297338;
	bh=+Gfask0StiWLlUCch117SuXIw8xsNI8oykJKkmQ2wAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJEzXRaWZAN5yySsAndaP5nSYjl6ifKb86/SZVKbnbKMcDOsrIkjE2Thc0X5WklXS
	 YIonr+hqMwo2/6K+mpyE/CnpSn5JqyHyRrFIXosylM0HY3AmsjWuD4v4+ezRvmz6gB
	 KhsFM2YtzZc7Cr6NdPUN6KCECZfxRI9cOGoXinSRpM6bD/Kp3GbdxqpuV6+tVzp3ob
	 Xf0ZPRZt6cu4aw77kiuKP0s0/RUIgTyDNttnuxY4k8XfMXPqsXPlGzMB1rgfeNuQeb
	 myc8YtyXo/u6cMf8Fg/lRS+cBbsoYY8MUND5O9VMuIXeTiZyR9OjYWxOuHT8Qfbfxp
	 oDop8zr6bTbDQ==
Date: Mon, 30 Jun 2025 08:28:57 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
	fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	john.g.garry@oracle.com
Subject: Re: [PATCH v2 02/13] common/rc: Fix fsx for ext4 with bigalloc
Message-ID: <20250630152857.GC9995@frogsfrogsfrogs>
References: <cover.1750924903.git.ojaswin@linux.ibm.com>
 <4f09b788f506223c9631479d0318be1e1ba5883c.1750924903.git.ojaswin@linux.ibm.com>
 <20250626133239.GA7524@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626133239.GA7524@mit.edu>

On Thu, Jun 26, 2025 at 09:32:39AM -0400, Theodore Ts'o wrote:
> On Thu, Jun 26, 2025 at 05:28:53PM +0530, Ojaswin Mujoo wrote:
> > This is achieved by defining a new function _set_default_fsx_avoid
> > called via run_fsx helper. This can be used to selectively disable
> > fsx options based on the configuration.
> 
> > +_set_default_fsx_avoid() {
> > +       case "$FSTYP" in
> > +       "ext4")
> > +               if [[ "$MKFS_OPTIONS" =~ bigalloc ]]; then
> > +                       export FSX_AVOID+=" -I -C"
> > +               fi
> > +               ;;
> 
> This assumes that MKFS_OPTIONS reflects the file system features
> enabled on the file system.  That's true by definition for the scratch
> fs, but it's not necessarily true for the test fs.  At least in
> theory, someone could run fstests without a scrach device, and then
> MKFS_OPTION?S might not be set.
> 
> I'm not sure that we care; is this something that we make assumptions
> in other tests?

/me suspects it ought to be checking dumpe2fs -h output.

--D

> 
> 					- Ted
> 
