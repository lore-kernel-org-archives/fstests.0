Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFF61D0DD1
	for <fstests@vger.kernel.org>; Tue,  6 Aug 2024 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722949895; cv=none; b=FPzufndBBH98lJq+25MtFsczoloQY8AfkZXOrd69Pjhpw6UTi9FJAH7aknuXYZC5I4537nMsTSzr25ojXdJPCY5nbZ9alu1F+6/aetuw15HYhXmIU2MNq7MNttxY7fDVpVu/9RFqzI3dS369OhwU3LECiEAvzSLV+esYWWWZj1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722949895; c=relaxed/simple;
	bh=yZqx/KdM3Mhsjk+PF/U4JhE0DqNVsTUVLZS45tA7TSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgZ8L7KLAKQhXHmvF0EAMJMG6ynMvxxRAIfFM5Zs/VV+ZaA8tw5jxS1HdcsUEsZScxvkXGeWTxzJLOm/kQ3SiVyExR7uteZu27XsltX0tcr2I9OzJJRApsXChcGghwUOuGKkg4Oo0S2JdIVpzwkJ9yoH2vtdhSMW8uI+MglXnLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d7V48ja0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d7V48ja0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722949892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JINr49d4RPR3AeRa9pOfTsblK53ClrVsMdQ5dglrQvY=;
	b=d7V48ja0+UTf+lXH8bn6/mq7yoMLeHCyXpbRVUMwpoQOycujpcHlq+LuhDlBbha50wykoE
	tkPay/M6DMRlKWpnqxENKhvVk3604zO3AC7tPavvfRX0YevunJZJbXly+DVHmbU2UieCQu
	K8esvr+bjpoP12iBN+TbszVFYmMkNEo=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-w5GojO0SM_ytHFkjCsOETg-1; Tue, 06 Aug 2024 09:11:31 -0400
X-MC-Unique: w5GojO0SM_ytHFkjCsOETg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-70d35b705d3so718449b3a.3
        for <fstests@vger.kernel.org>; Tue, 06 Aug 2024 06:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722949890; x=1723554690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JINr49d4RPR3AeRa9pOfTsblK53ClrVsMdQ5dglrQvY=;
        b=i4Qy0tmDhGICgoiPzjLAfJBBIqLTtEVRaEi6FwX/ApK4OEa3p7/+5wKa9/IkpNs9jH
         ztAY2csd0JKaJUvfK2tKCQShtMz851L+5RRn2ktMSqRRxGYiYcXhIKbg97cSDsWFYHZ+
         TR2nKKNGnZw5OV1P9LbfgPDzAFCGMBufHldsTsfJPb0e55xleAE0hkIGhJn21h5iutCQ
         sSLMzExn3woMhHP+nLs/H9tHjooOuTz597Cn9oZlusG5mPF7zU349Y66jlwPQnQ9STqb
         XFsYkLaWZnZp7CZgtJ8IabY6Y3ZI40ri5Lx7lWyClHOqydXjdaGDPaNoUPHTH84enBF2
         0Cdg==
X-Forwarded-Encrypted: i=1; AJvYcCVh0hYRFnd0z3zZtDxO+si83PnkSd/B0pjf3cEjA0020ZQCrE96Vi1TjEQeuGGG26pyCrItSEogFUok9C14HaKYiRqaEUuohQ==
X-Gm-Message-State: AOJu0Yx/G/HI6W04gnApeX/kYh1rTED9g5uN8SRpbglHxl/gwz4OThlk
	9gYuttI+3ihT7ZJvxcjAJJdXheQwNbMaqxd+1sZD4OoW3vMy2vCRpbiCT5+cOroBdTZdSvZ53FT
	UlRalMOKSWRjaW4PBsEeJbvstY+3qXtrdhINt2kvvAOpUEbr6d76s5F4bRMF6qcg=
X-Received: by 2002:a05:6a00:9481:b0:70b:aa7:3232 with SMTP id d2e1a72fcca58-7106d046169mr15953836b3a.27.1722949890298;
        Tue, 06 Aug 2024 06:11:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvq3PT4ppFNca5AsMqeG00J7nRPYXcXgxtbBzi7UjPzCo+cXOU22hW5ETICl5xQowIA5xEog==
X-Received: by 2002:a05:6a00:9481:b0:70b:aa7:3232 with SMTP id d2e1a72fcca58-7106d046169mr15953792b3a.27.1722949889689;
        Tue, 06 Aug 2024 06:11:29 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b76346b394sm5837964a12.23.2024.08.06.06.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 06:11:29 -0700 (PDT)
Date: Tue, 6 Aug 2024 21:11:25 +0800
From: Zorro Lang <zlang@redhat.com>
To: Daniel Gomez <da.gomez@samsung.com>
Cc: Zorro Lang <zlang@kernel.org>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH v2 4/5] common/rc: read config section mount options for
 scratch devs
Message-ID: <20240806131125.vyd4fqvj4cvchics@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240630-common-fixes-v2-0-16d26fb1dee0@samsung.com>
 <20240630-common-fixes-v2-4-16d26fb1dee0@samsung.com>
 <CGME20240712094934eucas1p1311bcdc37bccf98bdf5496cedd8df495@eucas1p1.samsung.com>
 <20240712093341.ftesijixy2yrjlxx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <bihbprnxplarjpmydllesefqfwpsx77n4aksnh3madutu52bcp@k245lusqxu6w>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bihbprnxplarjpmydllesefqfwpsx77n4aksnh3madutu52bcp@k245lusqxu6w>

On Mon, Aug 05, 2024 at 12:04:29PM +0000, Daniel Gomez wrote:
> On Fri, Jul 12, 2024 at 05:49:24PM GMT, Zorro Lang wrote:
> > On Sun, Jun 30, 2024 at 11:52:43PM +0200, Daniel Gomez via B4 Relay wrote:
> > > From: Daniel Gomez <da.gomez@samsung.com>
> > > 
> > > MOUNT_OPTIONS for scratch devices do not have specific fs mount options
> > > values (such as TMPFS_MOUNT_OPTIONS) from the config section. So, allow
> > > the scratch mount options to inherit section config values by reading
> > > them from _common_mount_opts().
> > > 
> > > Move $* to the end so scratch device can be umount/mount. Otherwise, we
> > > end up with multiple mounts in the same scratch directory.
> > > 
> > > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > > ---
> > >  common/rc | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index 51827119c..627dbaaaa 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -231,8 +231,8 @@ _scratch_mount_options()
> > >  {
> > >  	_scratch_options mount
> > >  
> > > -	echo `_common_dev_mount_options $*` $SCRATCH_OPTIONS \
> > > -					$SCRATCH_DEV $SCRATCH_MNT
> > > +	echo `_common_mount_opts` $SCRATCH_OPTIONS \
> > > +					$SCRATCH_DEV $SCRATCH_MNT $*
> > 
> > Oh, you want to get the "specific fs mount options". But sorry this
> > change brings in many regression failures, e.g. generic/219, generic/691,
> > generc/381, generic/382 ... fail (on ext4 and so on).
> 
> Kindly ping.
> 
> Following my previous question, I'm trying to elaborate more:
> 
> Could you please clarify why these specific filesystem mount options should not
> be applied to scratch devices? If this is a regression, could it be due to
> the application of $EXT_MOUNT_OPTIONS? And maybe a configuration issue?

It's not an issue about "if these specific filesystem mount options should not
be applied to scratch devices". The thing is _common_dev_mount_options() and
_common_mount_opts() are totally different two functions, we shouldn't replace
one with the other rudely. You change brought in _common_mount_opts, then removed
the _common_dev_mount_options directly, but they're not equivalent substitution.

> 
> The purpose of this change was to provide the common mount options for scratch
> devices, so that I can inherit the required options for tmpfs (e.g., '-o size=1G
> $TMPFS_MOUNT_OPTIONS').

BTW, I'm wondering, as you've done this below change in [PATCH 3/5]:

  @@ -802,7 +802,7 @@ get_next_config() {
          fi

          parse_config_section $1
  -       if [ ! -z "$OLD_FSTYP" ] && [ $OLD_FSTYP != $FSTYP ]; then
  +       if $RECREATE_TEST_DEV || ([ ! -z "$OLD_FSTYP" ] && [ $OLD_FSTYP != $FSTYP ]); then
                  [ -z "$MOUNT_OPTIONS" ] && _mount_opts

Won't that help to reset "MOUNT_OPTIONS" to "-o size=1G $TMPFS_MOUNT_OPTIONS", if
you set RECREATE_TEST_DEV=true in a new section?

Thanks,
Zorro

> 
> Here is my current configuration, but it seems I'm missing something, as I'm
> expecting the scratch (and test) mounts to inherit $TMPFS_MOUNT_OPTIONS when
> running ./check -s <config>.
> 
> mkdir -p /media/scratch
> mkdir -p /media/test
> export FSTYP=tmpfs
> export SCRATCH_DEV=/media/scratch
> export SCRATCH_MNT=/media/scratch
> export TEST_DEV=/media/test
> export TEST_DIR=/media/test
> export RECREATE_TEST_DEV=true
> 
> # Test with default mount options
> [tmpfs_default]
> 
> [tmpfs_noswap_huge_never]
> TMPFS_MOUNT_OPTIONS="-o noswap,huge=never"
> 
> [tmpfs_noswap_huge_always]
> TMPFS_MOUNT_OPTIONS="-o noswap,huge=always"
> 
> > 
> > Thanks,
> > Zorro
> > 
> > >  }
> > >  
> > >  _supports_filetype()
> > > 
> > > -- 
> > > 2.43.0
> > > 
> > > 
> > > 
> 

