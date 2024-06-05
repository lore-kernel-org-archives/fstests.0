Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3895E19D8B0
	for <fstests@vger.kernel.org>; Wed,  5 Jun 2024 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717598181; cv=none; b=CgTN+A6FHzzl0YIl2A0bAEhh8M1KSMieqMO4GuYY2bVlAQ4zrsV+F7/rXUeg07Km1GoK+lBkcIbg5vn342lW5tkQ4mkUdmiEKVUIRkzD5XfjdAMrMybBgrbYQQkUSh9hNomULNKqO5zoPk0IOgcsweJU58MCO3IaOnZDgUtk1SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717598181; c=relaxed/simple;
	bh=Tal0qhTecUru/gli8KoTXltxrlvE7DgQ5n3kwHCtqd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/32wJyiANgJaiItjkL2j7uwscz/yXG7I/+9GOI1ESaqBzdCDTXvM5qZR74DnuGOtlDkEjC11zXcb9DUIpDJwXYZ4kFuHNqW7Mjku7MGW+vrI0vaYhznDpS9FHT/7dDFMVAH5eCg+xmx/jHW0qMzyFvbaUrofCK6xiFJvFsg3tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJkGBGm3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJkGBGm3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E10DC2BD11;
	Wed,  5 Jun 2024 14:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717598180;
	bh=Tal0qhTecUru/gli8KoTXltxrlvE7DgQ5n3kwHCtqd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SJkGBGm3s/pWvUsB34RrIvU6non32WN/QG18Dv6SkB9O0yVAOjS43hdmmmbGMX22D
	 pZbUbHedygjnr9r1DsgrNUWtm0vtpBROOWAwCTk48F1B7uInhe6UIkz4POEzlBIa/Q
	 gEywflAVxP7LnpT6HYMcFbeWqcmyfB0bSnRNRcgyIpzsPn1TM3o1JolGbAcgTzcWs6
	 kmzZDulfVEa3R0Mv5e7PRBI51u/PORjiG06WBjeLw5jq8zOxNkuhXFC8QKzpaV14y+
	 b93c+tCegGQm80Vmnrb2hEcX9XeujuT76/eHBEwPPGihpCiulqtj2jVRNlNVMs9CI/
	 oBzp5wuiNxUtQ==
Date: Wed, 5 Jun 2024 07:36:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: fix _require_debugfs and call it properly
Message-ID: <20240605143619.GB52977@frogsfrogsfrogs>
References: <20240429060906.465135-1-zlang@kernel.org>
 <Zl_pO3nHTDWABxrd@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl_pO3nHTDWABxrd@bombadil.infradead.org>

On Tue, Jun 04, 2024 at 09:27:39PM -0700, Luis Chamberlain wrote:
> On Mon, Apr 29, 2024 at 02:09:06PM +0800, Zorro Lang wrote:
> > The old _require_debugfs helper doesn't work now, fix it to check
> > a system supports debugfs. And then call this helper in cases which
> > need $DEBUGFS_MNT.
> > 
> > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > ---
> >  common/rc       | 10 ++++++++--
> >  tests/btrfs/150 |  1 +
> >  tests/ceph/001  |  2 +-
> >  tests/xfs/499   |  1 +
> >  4 files changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/common/rc b/common/rc
> > index 56f1afb6..6f0bdf60 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -2978,8 +2978,14 @@ _require_sparse_files()
> >  
> >  _require_debugfs()
> >  {
> > -    #boot_params always present in debugfs
> > -    [ -d "$DEBUGFS_MNT/boot_params" ] || _notrun "Debugfs not mounted"
> > +	local type
> > +
> > +	if [ -d "$DEBUGFS_MNT" ];then
> > +		type=$(findmnt -rncv -T $DEBUGFS_MNT -S debugfs -o FSTYPE)
> 
> With:
> 
> -S debugfs
> 
> On debian this returns nothing. Removing that fixes it on debian. I'll
> send patch.

What version?  This is what I see:

$ findmnt -rncv -T /sys/kernel/debug -S debugfs -o FSTYPE
debugfs
$ cat /etc/debian_version
12.5

(Did something break again?)

--D

> 
>   Luis
> 
