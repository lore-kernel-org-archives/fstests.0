Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3161428F1
	for <fstests@vger.kernel.org>; Mon, 24 Jun 2024 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247636; cv=none; b=QDXyyGijzu00mRs+NL0pNr088SkgC55tQ43OWorNnVbl/lq/QsK8OvvOu7hP4371sfL716+3L6PiTT23x7v6m3mh+CKsUcXxnIh0kMT5qY45FHJf7oDeH5DbyC8u7oAzwV5T6VIj6kL6UyKnWLsV99u/fZXEYpYKHIHn6QULrPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247636; c=relaxed/simple;
	bh=gG7eP+BWelIwvq3dlu8NKn313UTsNfmw89w9Nn3O1Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lv8U9/3Ll8Vu5om3oIeHCE9fLZfy5F2HUr6tTbfkOQmqJkz2Ndvib/81f9rPBGXYnw+PhfkXF0qOXzsb7zyV5yLOZuE2cKKS91NHOlMsSKAMVCaQHX3hcPgxIffUypbHrKEjFZxBLvE2quZ6JQYaw2qF1/gberyHbxsF5BPTuQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLfqFXNn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLfqFXNn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06EFC2BBFC;
	Mon, 24 Jun 2024 16:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719247635;
	bh=gG7eP+BWelIwvq3dlu8NKn313UTsNfmw89w9Nn3O1Jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RLfqFXNn2/1MKWHWNrshetiXYEdzC5u+604d+xNbbmGpSLJQiqStYOgrna6hj2Wan
	 jXBto/lfmwCMQDFPGISWNn9/1+omy9ssM8N5Ebttqs0Cdy8WbEOFla80kbz6GmFXg/
	 hLCTWWUuJoX5hAJx/FGgiuUAOGb6hRbOyRJP9uVAPVakMVzjF5A3HO98SuBKf+oucE
	 lTkqDBijcq1FaY39CfMVqRG3GdbkzGc65DpMdQd5I8Hy2Fw6c/h59HCSBu4e6Gd9CB
	 /HtyORg+PwqZyimxvvflc7l5bsL5ErQs7UZjJJ+3hYmNB74gr5o5G59WB7xLKLH2id
	 tOWkzYlXUXy7g==
Date: Mon, 24 Jun 2024 09:47:15 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Daniel Gomez <da.gomez@samsung.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>,
	"hughd@google.com" <hughd@google.com>
Subject: Re: [PATCH 4/5] common/rc: fix scratch mount options for tmpfs
Message-ID: <20240624164715.GI103020@frogsfrogsfrogs>
References: <20240614061722.1080-1-da.gomez@samsung.com>
 <CGME20240614061727eucas1p19ba98d45511f9226f1c5cf1752b419b5@eucas1p1.samsung.com>
 <20240614061722.1080-5-da.gomez@samsung.com>
 <20240614154728.GC6110@frogsfrogsfrogs>
 <jnyfwimjjfi56fqbfb4lvrauzinkgokdsftxa4k4o5o7eomokm@ghgk5vt46rcz>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jnyfwimjjfi56fqbfb4lvrauzinkgokdsftxa4k4o5o7eomokm@ghgk5vt46rcz>

On Mon, Jun 24, 2024 at 01:50:33PM +0000, Daniel Gomez wrote:
> On Fri, Jun 14, 2024 at 08:47:28AM GMT, Darrick J. Wong wrote:
> > On Fri, Jun 14, 2024 at 06:17:25AM +0000, Daniel Gomez wrote:
> > > Make sure tmpfs scratch device inherits the extra tmpfs mount options
> > > variable (TMPFS_MOUNT_OPTIONS).
> > > 
> > > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > > ---
> > >  common/rc | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index 7f995b0fa..a42792c37 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -224,7 +224,7 @@ _test_options()
> > >  # hosted on $SCRATCH_DEV, so can't use external scratch devices).
> > >  _common_dev_mount_options()
> > >  {
> > > -	echo $MOUNT_OPTIONS $SELINUX_MOUNT_OPTIONS $*
> > > +	echo $MOUNT_OPTIONS $SELINUX_MOUNT_OPTIONS $TMPFS_MOUNT_OPTIONS $*
> > 
> > Why is it necessary to include tmpfs mount options for all fs types?
> > XFS does not accept tmpfs mount options.
> 
> You are right. We should not do this.
> 
> However, _scratch_mount_options() calls _common_dev_mount_options() ignoring the
> specific mount options based on fstyp.

Ah, _mount_opts only gets run for configuration files.

> specific mount options based on fstyp. Replacing it with _common_mount_opts()
> makes this work. In addition, _common_dev_mount_options() function description
> says 'Used for mounting non-scratch devices with the safe set of scratch mount
> options'. So, why is it used to mount scratch devices?

I think the comment isn't very good.  Six of the seven callers:

common/dmdelay|23| _mount -t $FSTYP `_common_dev_mount_options` $SCRATCH_OPTIONS \
common/dmdust|19| _mount -t $FSTYP `_common_dev_mount_options $*` $SCRATCH_OPTIONS \
common/dmerror|94| _mount -t $FSTYP `_common_dev_mount_options $*` $SCRATCH_OPTIONS \
common/dmlogwrites|107| _mount -t $FSTYP `_common_dev_mount_options $*` $SCRATCH_OPTIONS \
common/dmthin|226| echo `_common_dev_mount_options $*` $SCRATCH_OPTIONS $DMTHIN_VOL_DEV $SCRATCH_MNT
common/rc|272| echo `_common_dev_mount_options $*` $SCRATCH_OPTIONS \

appear to use this to mount the scratch filesystem from devices that are
not the regular scratch device.  The one exception is this one:

common/overlay|32| _mount -t overlay $diropts `_common_dev_mount_options $*`

which AFAICT seem to mount arbitrary overlayfs instances with some of
the mount options.

> This fixes the issue:
> 
> diff --git a/common/rc b/common/rc
> index 51827119c..627dbaaaa 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -231,8 +231,8 @@ _scratch_mount_options()
>  {
>         _scratch_options mount
> 
> -       echo `_common_dev_mount_options $*` $SCRATCH_OPTIONS \
> -                                       $SCRATCH_DEV $SCRATCH_MNT
> +       echo `_common_mount_opts` $SCRATCH_OPTIONS \
> +                                       $SCRATCH_DEV $SCRATCH_MNT $*
>  }
> 
> > 
> > For that matter, why is TMPFS_MOUNT_OPTIONS necessary at all?  Shouldn't
> > that simply be "MOUNT_OPTIONS=<stuff> FSTYP=tmpfs ./check" ?
> 
> TMPFS_MOUNT_OPTIONS is used to specify mount options in each section of the
> configuration file. For example, the following snippet is part of my conf file:
> 
> ```
> [tmpfs_noswap_huge_always]
> TMPFS_MOUNT_OPTIONS="-o noswap,huge=always"
> 
> [tmpfs_noswap_huge_within_size]
> TMPFS_MOUNT_OPTIONS="-o noswap,huge=within_size"
> ```
> 
> Then I run -s option to switch between profiles, e.g., 'check -s
> tmpfs_noswap_huge_within_size -R xunit -g auto'.
> 
> I’m not sure if this addresses your question. Please let me know if I
> misunderstood.

Ahah, this is one of those parts of fstests that differ depending on
whether you use configuration files (you do) or not (I don't).  AFAICT,
get_next_config has this slightly odd (to me) behavior where if a config
section doesn't explicitly set MOUNT_OPTIONS, it will reuse
MOUNT_OPTIONS from a previous section if FSTYP hasn't changed.  You
instead want to change the mount between sections

So I /think/ the correct thing to do here is

[tmpfs_noswap_huge_always]
MOUNT_OPTIONS="-o noswap,huge=always"

[tmpfs_noswap_huge_within_size]
MOUNT_OPTIONS="-o noswap,huge=within_size"

Though I'm not exactly an expert on these things.

--D

> 
> > 
> > --D
> > 
> > >  }
> > >  
> > >  _scratch_mount_options()
> > > -- 
> > > 2.43.0
> > > 
