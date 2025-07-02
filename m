Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF8A265632
	for <fstests@vger.kernel.org>; Wed,  2 Jul 2025 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751469222; cv=none; b=dgu5fLyCl76wKPXdXHApjAk8YoCXnqT2tu0vEi33IvD4TLDt60SXCVuyxvqsDruXt+TFlzcm7I4+8nD2Vj8le3yLrz/mA2rgSjv5prx4BNoyJ7ukfsj52sm/DeFuUL9a0V3p3RVJqehKT6bIPcKm0b3cAlMPCW13aIMYnB67WR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751469222; c=relaxed/simple;
	bh=8+4oPblCxCirN3eIvakQhR2MRlCq4KuZGTwPcgHuFr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6W8sdNtYo7SK+kK1e1giwCcnbY2Kth8h9D6Pi9eCyoL0ZxQzDXyueCFCH4rI9RhsY5XAgulLUlfKaCOXyYGxwR8PYVY3T7w4rguAdLOnuS86LTWjjGx1lHDInS6eq112bdSzdO22dY+d4Q+90Zs5zIr2E/RQTOrARGg495mtqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1VTkgV8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1VTkgV8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA56EC4CEED;
	Wed,  2 Jul 2025 15:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751469221;
	bh=8+4oPblCxCirN3eIvakQhR2MRlCq4KuZGTwPcgHuFr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t1VTkgV8cgiHYJ6kZwhqQlTWLPlMZn2oLSubsYf8N0z+Ct0/pDKmSP1msXfeVKbSe
	 NnloYW95fz8tYeOHLXl9gwBcuyZhHLQapR1fLl6WKlJbpvC/DpE3hyeinW3pE/tb2m
	 h2gTYHhkmBqVRbUm1ZsI1KGueP0qcaAj+odUCnD4QoYv/ieLGXF5BQvwxhbax6qrJw
	 En0DYfIHZdNeyae8gaPEwu0sHm/YQfS80DE4S1oglsMtiVpdo6ieeNPalPvpWik4Yy
	 Tm7v2tZhB2SE0GxPOzOJY1KfZ71lSJug/7fo7oAmLag1spZxVN4sYrt5XrbtiTAQL8
	 w0JiT2Am47cUg==
Date: Wed, 2 Jul 2025 08:13:41 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Zorro Lang <zlang@redhat.com>,
	fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	john.g.garry@oracle.com
Subject: Re: [PATCH v2 02/13] common/rc: Fix fsx for ext4 with bigalloc
Message-ID: <20250702151341.GD9995@frogsfrogsfrogs>
References: <cover.1750924903.git.ojaswin@linux.ibm.com>
 <4f09b788f506223c9631479d0318be1e1ba5883c.1750924903.git.ojaswin@linux.ibm.com>
 <20250626133239.GA7524@mit.edu>
 <20250630152857.GC9995@frogsfrogsfrogs>
 <aGN_ezRRQFuydHmS@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGN_ezRRQFuydHmS@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Tue, Jul 01, 2025 at 11:56:03AM +0530, Ojaswin Mujoo wrote:
> On Mon, Jun 30, 2025 at 08:28:57AM -0700, Darrick J. Wong wrote:
> > On Thu, Jun 26, 2025 at 09:32:39AM -0400, Theodore Ts'o wrote:
> > > On Thu, Jun 26, 2025 at 05:28:53PM +0530, Ojaswin Mujoo wrote:
> > > > This is achieved by defining a new function _set_default_fsx_avoid
> > > > called via run_fsx helper. This can be used to selectively disable
> > > > fsx options based on the configuration.
> > > 
> > > > +_set_default_fsx_avoid() {
> > > > +       case "$FSTYP" in
> > > > +       "ext4")
> > > > +               if [[ "$MKFS_OPTIONS" =~ bigalloc ]]; then
> > > > +                       export FSX_AVOID+=" -I -C"
> > > > +               fi
> > > > +               ;;
> > > 
> > > This assumes that MKFS_OPTIONS reflects the file system features
> > > enabled on the file system.  That's true by definition for the scratch
> > > fs, but it's not necessarily true for the test fs.  At least in
> > > theory, someone could run fstests without a scrach device, and then
> > > MKFS_OPTION?S might not be set.
> > > 
> > > I'm not sure that we care; is this something that we make assumptions
> > > in other tests?
> > 
> > /me suspects it ought to be checking dumpe2fs -h output.
> > 
> > --D
> 
> Hey Ted, Darrick,
> 
> I agree that MKFS_OPTIONS is not ideal because it won't reflect the
> TEST_DEV options. Most of the existing users of run_fsx helper actually
> use the TEST_DEV instead so Darrick's suggestion of using dumpe2fs makes 
> sense. 
> 
> I can use that approach in v3 if that sounds okay to everyone.

Sounds fine to me...

--D

> Regards,
> ojaswin
> 
> > 
> > > 
> > > 					- Ted
> > > 
> 
