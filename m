Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E55246BC9
	for <fstests@vger.kernel.org>; Thu, 12 Jun 2025 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749738975; cv=none; b=lHnu51h1FKTJJh7Fd/Bs60yfE2PHh12PX+ZhBljPBKivfRdz8bNC4CjSUt0FOoXGCuSr1DXEe1VJHjolzeD5yuerSWTMEpLQy4rg7pc7V1iFxmaFzjBh7WNsHtxeujKnS9u6sZVxSVCl2SMdG4bvVE+aHUxr9j0K3KsRxfYGUI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749738975; c=relaxed/simple;
	bh=Mhuz5mjYep4eLYa8CpChCwixa78dRVFsnRXcz97sjMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAu4Ae4i8mxnUa9smt6+rcg/xRjPxXBxuUDapBiogDfGQzZXG8lZWaEjS0FnUT+c1ZRYSjDiwVRZaHJp9PQm0tVo7Gp7o4Hf9mD7QgO/BhKWsHpfyMgsZ1HnEN+tnyP/kZNmD8VKNAz2BHjZS8LUVnE6hjIKkcCi1LHGHwz624k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZTLarPX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZTLarPX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B998EC4CEEA;
	Thu, 12 Jun 2025 14:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749738974;
	bh=Mhuz5mjYep4eLYa8CpChCwixa78dRVFsnRXcz97sjMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RZTLarPXym1YALaaN6uQH09rusnzUueKhN92m1ox6JCmuCwQ3mj4AKaw7G+wCP7CS
	 UdV+0OuJV2svupd93kDuhP6zgxGht7yigLVvCDnVSisTRDQbNpSar9z1VcK8+sGNF2
	 6aAamhe3g9SwG/+seZpc4a2UFVRSStrCXvjAxvOBOF8SV2gWoT4NP2ReN46ILeKDx3
	 DkaEqk3ChL7thIRz8Wis5RUa7MJflv9xxkDRDbrIph103b/9iCV5wCWtTDbQHNOblm
	 x4XOEeEhW3g+fMSn3vEB02wG5NqHZ+nTz9rInlyPDaexraFAxYz+lhr3iJNcdKW3g/
	 SWKA/ctMUbCMQ==
Date: Thu, 12 Jun 2025 07:36:14 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	john.g.garry@oracle.com, tytso@mit.edu
Subject: Re: [RFC 01/12] common/preamble: Fix fsx for ext4 with bigalloc
Message-ID: <20250612143614.GR6143@frogsfrogsfrogs>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <2568ed1e9d1c47d0fdb357f0e10c5ed341a72379.1749629233.git.ojaswin@linux.ibm.com>
 <20250611143005.GF6143@frogsfrogsfrogs>
 <aEpvhNjDHXvFXSIJ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEpvhNjDHXvFXSIJ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Thu, Jun 12, 2025 at 11:41:16AM +0530, Ojaswin Mujoo wrote:
> On Wed, Jun 11, 2025 at 07:30:05AM -0700, Darrick J. Wong wrote:
> > On Wed, Jun 11, 2025 at 03:04:44PM +0530, Ojaswin Mujoo wrote:
> > > From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> > > 
> > > Insert range and collapse range only works with bigalloc in case
> > > the range is cluster size aligned, which fsx doesnt take care. To
> > > work past this, disable insert range and collapse range on ext4, if
> > > bigalloc is enabled.
> > 
> > Hmmm, insert/collapse-range have the same behavior on xfs realtime,
> > maybe we should amend test() in fsx to round to the allocation unit
> > size?
> Hey Darrick,
> 
> Yes makes sense but as you mentioned, I'm not sure if there
> is a way to programatically detect the bigalloc cluster size (or
> allocation unit in general) like we do for xfs. 

I don't either, but maybe we should have a way reveal the allocation
unit size for a given file?  Yet another statx field? :P

(It /would/ be useful for programs that use collapse/insert range)

--D

> (Adding Ted to CC in case he has some idea)
> > 
> > Querying that programmatically might be ... interesting though.  Is
> > there a good way to do that for ext4 bigalloc?
> > 
> > (See detect_xfs_alloc_unit in punch-alternating.c)
> > 
> > --D
> > 
> > > This is achieved by defining a new function _setup_fs_options
> > > which can serve as a mechanism to apply FS-wide options to
> > > the tests.
> > > 
> > > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > ---
> > >  common/preamble | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/common/preamble b/common/preamble
> > > index ba029a34..2bccff74 100644
> > > --- a/common/preamble
> > > +++ b/common/preamble
> > > @@ -24,6 +24,20 @@ _register_cleanup()
> > >  	trap "${cleanup}exit \$status" EXIT HUP INT QUIT TERM $*
> > >  }
> > >  
> > > +# setup FS options only to be available for each test run
> > > +_setup_fs_options() {
> > > +	case "$FSTYP" in
> > > +	"ext4")
> > > +		if [[ "$MKFS_OPTIONS" =~ bigalloc ]]; then
> > > +			export FSX_AVOID="-I -C"
> > > +		fi
> > > +		;;
> > > +	# Add other filesystem types here as needed
> > > +	*)
> > > +		;;
> > > +	esac
> > > +}
> > > +
> > >  # Prepare to run a fstest by initializing the required global variables to
> > >  # their defaults, sourcing common functions, registering a cleanup function,
> > >  # and removing the $seqres.full file.
> > > @@ -55,4 +69,6 @@ _begin_fstest()
> > >  	# remove previous $seqres.full before test
> > >  	rm -f $seqres.full $seqres.hints
> > >  
> > > +	# setup filesystem options for a given test execution
> > > +	_setup_fs_options
> > >  }
> > > -- 
> > > 2.49.0
> > > 
> > > 
> 
