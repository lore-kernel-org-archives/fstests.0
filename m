Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F7B14277
	for <fstests@vger.kernel.org>; Fri, 28 Jun 2024 03:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544420; cv=none; b=Ht+hexHAGvslbVmOBbxB4eUWDGgSNPigiZEUJL1TxHblfGy1lHATqc+3CShJb4xBnxqSLf4k62tjaHG6xFIeMcI7RCYokG9u5gfapzcCYL85/3qgcnXYHHeNLmCQ8MOybdUiLzMwR49Uhb8UNKre6eW9jAHKTaffhlkrfRS7J8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544420; c=relaxed/simple;
	bh=lktT3XUhaICOIYIcllyaFWdXGOX5l/FqilmWqevYsE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGEoByitCJcVcyIogdsTZYnTv0aNGCpGy1RcaP/DCob8ZOFj7nD3X0DHnPgU2e26rgRFti5ysykBvEqDA4UvWxhwNDiILqTG66Gln3Otqu9uhmH11GZJBHmHtupv8d3rjsUl90VWa3yJJIEXGR7xraFcXEPhgGCGB2YL7U35kZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=blI7dyxw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blI7dyxw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719544417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LGm+2Hp+IavyzkAMvix+NDpqTPQBdjQv/6D8krCrSg0=;
	b=blI7dyxwOhjhbc3vPbDBjKmEDzghCqb3oM+FK59EmQJPuklcf4u++1+9Bw9k+kYFL7Qa/x
	yVGM/3biBe760LuPSFobckWzze2FVfjZRpFKlLVlExa4xD82mgEFoDTg8ysjL5AtUF+ynk
	Qiu/Ct76HYFIwbY3IrA5OOEmzhWzHys=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-8M6IZ2FpPCGDtLPffXmrSw-1; Thu, 27 Jun 2024 23:13:36 -0400
X-MC-Unique: 8M6IZ2FpPCGDtLPffXmrSw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-649731dd35bso136503a12.0
        for <fstests@vger.kernel.org>; Thu, 27 Jun 2024 20:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719544415; x=1720149215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGm+2Hp+IavyzkAMvix+NDpqTPQBdjQv/6D8krCrSg0=;
        b=ByWZJJ3NVnxBZeo/G0ULmixcuVEoeFaTlAeALuW2zAzUXLMAsMK1PtJbMxZW8GAbQn
         12lg03LfkK/TwVFEz+oiYZwgCYOi5lBf98/4aRUpr03pbTnR8TWttBEY5H6LLdIfNBPV
         Se0nFB5nhiiRWPkPzPuZSR275xftXuOl1dOgys5vTGUmRlqGbcV0WAHWQXuU+daEhatz
         LXYPb2kKMcJNiMpO3xPeuT4P1xzGm6jp4rWmPEWgYLxrwnhjewZTH+bDVYUDY8DIH+kE
         eggL1jQvJg8YaEi/iJEI92V063K9GomHclnsXRvEU1d0Ou+uJwOJ4owXW4QfeMa3qBEK
         Ha6A==
X-Gm-Message-State: AOJu0YzX+og8bxreerIvDTDCYMQu+k2dqrZVVop4+AY/pwQYJLsFI1t2
	cRSXZAGHMbVPwVbaHOUafXSgxTljc4nrkgZGNmCksO/pj6jAmXGPMO91chaJHsNzd2l1oEtSj+2
	3TFSdQmu0WnYbNx6tilfqAwad+2Zu2WskKmMrHUL7+rBkn+t3Ey336sMemXK7bOIXOw==
X-Received: by 2002:a05:6a20:748c:b0:1bd:2413:a963 with SMTP id adf61e73a8af0-1becda2b052mr5356640637.41.1719544414523;
        Thu, 27 Jun 2024 20:13:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSCedbKW0PPTbV9NKPuKdkeHNVe4GYHroVuuOSztOdPMVldpbFu+lu/gGyWg65iAEM6tiL3w==
X-Received: by 2002:a05:6a20:748c:b0:1bd:2413:a963 with SMTP id adf61e73a8af0-1becda2b052mr5356619637.41.1719544413833;
        Thu, 27 Jun 2024 20:13:33 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3bc718sm532536a91.35.2024.06.27.20.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 20:13:32 -0700 (PDT)
Date: Fri, 28 Jun 2024 11:13:28 +0800
From: Zorro Lang <zlang@redhat.com>
To: Daniel Gomez <da.gomez@samsung.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>,
	"hughd@google.com" <hughd@google.com>
Subject: Re: [PATCH 3/5] common/rc: add recreation support for tmpfs
Message-ID: <20240628031328.z3ehybrb2cnatksi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240614061722.1080-1-da.gomez@samsung.com>
 <CGME20240614061727eucas1p20922542ef700d0f41dc9cc9628392518@eucas1p2.samsung.com>
 <20240614061722.1080-4-da.gomez@samsung.com>
 <20240617070654.t3dvlvm4br354mpv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <y4z23gapu72ndr3kun7kx3pakrjlej57grqsocc6wgti5y3kqa@hmeylbnnnkza>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y4z23gapu72ndr3kun7kx3pakrjlej57grqsocc6wgti5y3kqa@hmeylbnnnkza>

On Mon, Jun 24, 2024 at 01:33:55PM +0000, Daniel Gomez wrote:
> On Mon, Jun 17, 2024 at 03:06:54PM GMT, Zorro Lang wrote:
> > On Fri, Jun 14, 2024 at 06:17:25AM +0000, Daniel Gomez wrote:
> > > Add support for test device recreation (RECREATE_TEST_DEV=true) for
> > > tmpfs. This allows to inherit the tmpfs profile extra mount options
> > > (TMPFS_MOUNT_OPTIONS) for the test device.
> > > 
> > > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > > ---
> > >  common/rc | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index 163041fea..7f995b0fa 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -457,7 +457,7 @@ _test_mount()
> > >      fi
> > >  
> > >      _test_options mount
> > > -    _mount -t $FSTYP$FUSE_SUBTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
> > > +    _mount -t $FSTYP$FUSE_SUBTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $TMPFS_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
> > 
> > We shouldn't use a FSTYP specific parameter in a common mount line.
> > Better to set it in a "$FSTYP=tmpfs" branch. I notice that we set:
> > 
> >         tmpfs)
> >                 # We need to specify the size at mount, use 1G by default
> >                 echo "-o size=1G $TMPFS_MOUNT_OPTIONS"
> > 
> > in _common_mount_opts(). Then it will be set in MOUNT_OPTIONS and
> > TEST_FS_MOUNT_OPTS, won't that help?
> 
> No for the recreation path with specific section variables as we have not yet
> source '. common/rc'. Dropping changes in _test_mount() and force reading test
> mount options makes $TMPFS_MOUNT_OPTION available for the test in the recreation
> path.
> 
> diff --git a/check b/check
> index 723a52e30..b3f7d7b14 100755
> --- a/check
> +++ b/check
> @@ -773,6 +773,7 @@ function run_section()
>                         status=1
>                         exit
>                 fi
> +               _test_mount_opts

Actually the get_next_config function (from common/config) should have reloaded
the mount and mkfs paramters.

run_section()
{
        ...
        get_next_config $section
        ...

        if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
                ...
                if ! _test_mkfs >$tmp.err 2>&1
                ...
                if ! _test_mount
                ...
}

But why it doesn't?

Oh, due to the get_next_config does things as this:

get_next_config() {
        ...
        unset MOUNT_OPTIONS
        unset TEST_FS_MOUNT_OPTS
        unset MKFS_OPTIONS
        unset FSCK_OPTIONS
        ...
        if [ ! -z "$OLD_FSTYP" ] && [ $OLD_FSTYP != $FSTYP ]; then
                [ -z "$MOUNT_OPTIONS" ] && _mount_opts
                [ -z "$TEST_FS_MOUNT_OPTS" ] && _test_mount_opts
                [ -z "$MKFS_OPTIONS" ] && _mkfs_opts
                [ -z "$FSCK_OPTIONS" ] && _fsck_opts
                ...
        else
                [ -z "$MOUNT_OPTIONS" ] && export MOUNT_OPTIONS=$OLD_MOUNT_OPTIONS
                [ -z "$TEST_FS_MOUNT_OPTS" ] && export TEST_FS_MOUNT_OPTS=$OLD_TEST_FS_MOUNT_OPTS
                [ -z "$MKFS_OPTIONS" ] && export MKFS_OPTIONS=$OLD_MKFS_OPTIONS
                [ -z "$FSCK_OPTIONS" ] && export FSCK_OPTIONS=$OLD_FSCK_OPTIONS
                [ -z "$USE_EXTERNAL" ] && export USE_EXTERNAL=$OLD_USE_EXTERNAL
        fi
        ...
}

Only if the later FSTYP is different with the former one, then get_next_config
reloads those OPTIONS.

1) That helps you don't need to set duplicated paramters in each section.
2) But that causes you can't reset/reload something likes TEST_FS_MOUNT_OPTS,
except you set MOUNT_OPTIONS, TEST_FS_MOUNT_OPTS, ... directly.

I'm not sure how many people depends on the 1)st behavior long time. And how
many people hope to remove the limitation of [ $OLD_FSTYP != $FSTYP ]. Any change
will be default behavior change.

But we might can bring the $RECREATE_TEST_DEV into get_next_config(), likes:
  if $RECREATE_TEST_DEV || ([ -n "$OLD_FSTYP" ] && [ "$OLD_FSTYP" != "$FSTYP" ])

I didn't give it a test, any better ideas are welcome :)

Thanks,
Zorro

>                 if ! _test_mount
>                 then
>                         echo "check: failed to mount $TEST_DEV on $TEST_DIR"
> 
> I understand from Darrick's comment that the change above in _test_mount() is
> wrong. Would this solution be okay? Not sure if this is a bug but I'd guess all
> specific mount options are now ignored in the recreation path (not only tmpfs).



> 
> > 
> > Thanks,
> > Zorro
> > 
> > 
> > >      mount_ret=$?
> > >      [ $mount_ret -ne 0 ] && return $mount_ret
> > >      _idmapped_mount $TEST_DEV $TEST_DIR
> > > @@ -604,6 +604,9 @@ _test_mkfs()
> > >      pvfs2)
> > >  	# do nothing for pvfs2
> > >  	;;
> > > +	tmpfs)
> > > +	# do nothing for tmpfs
> > > +	;;
> > >      udf)
> > >          $MKFS_UDF_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
> > >  	;;
> > > -- 
> > > 2.43.0
> > > 
> > 
> 

