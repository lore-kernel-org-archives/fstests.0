Return-Path: <SRS0=G1tu=X3=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69566C35280
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Oct 2019 11:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D892086A
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Oct 2019 11:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESJgFTdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfJBLAG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 2 Oct 2019 07:00:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36902 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfJBLAF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Oct 2019 07:00:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id c17so11663813pgg.4
        for <fstests@vger.kernel.org>; Wed, 02 Oct 2019 04:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UK3UHjVhJ3ZMTKZOjwjI/XlXGTSgE7uJiyeJAVBdmFs=;
        b=ESJgFTdzV63JDofuBJMEoGr4SgbobyFCryO8qVvFv4Q9HKZBgQ/Q38kBYy1u80+ezT
         9Ds9oqzY4q4Ihet2GyjcSbifQ33M/Rr8GDolIBeTam/yFXcwK89tcvk8Dv7e69BLtFIH
         FrA0sjiKTNY1ioNvwfwUN8KfhHjMntN7CPWNdXtMEf2pBKQ2ox2h5XCDFEyQIEZyFrZu
         MR9anR/5QjwlsR6/ZTIHXd87P579jL8p5h2M3d1GAZvaS3MRmMqetPjMHz+z7OC/YpSH
         mOY9RafiDFz8U4+oFxXdyM+6PBUWCLIYK9nQgqRFVWTocwi7ahaqprBXrzS2IG43Llj8
         ivCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UK3UHjVhJ3ZMTKZOjwjI/XlXGTSgE7uJiyeJAVBdmFs=;
        b=ppHWMplprjHFGYFNSZKfmWBxT0LDH8iOlyqRdJtJD7wTURFRc7oy4uB6mQd3o4811A
         BhEOJ5kIiufVEV8JnYLJvgbuQ4DtXWPRlCUfYC4wiLBGOp+MXs3h9uxSV9jsT6ivHk3y
         Eljhfkw8WXH8FRmcYIrVcxE0RPG/iHporhFAPP5rQnGvBuNKoBjgk4AV3TJ6NYgkuMpJ
         kXFxTZ2ZcX940kP19s9wMqqcc1QHOWrFFj3vOoKffzHsLpPnmt3TL9pEv1IhIsXAco5L
         Uc6AuxtF9E+YsF+hJu+OYimhS9ZmEPWcsF3AzRVmvYgsd2NxK4fR/yWz7wgKx/cUqXMH
         XdfQ==
X-Gm-Message-State: APjAAAXtg01Ka4eJkXEkLZRN4wo/wHHKCuSXQVIuvcbCYps3YXKhyJ1z
        mTqZ/4EV4ztUh/uBj51J6+U=
X-Google-Smtp-Source: APXvYqxMzXMpvvvlopGLf8ICyvVbJ56L6uHQCD9IJROitX7OIo+ljxSoc8ry3SgnpxKV5JPT+zAlSA==
X-Received: by 2002:a62:5a85:: with SMTP id o127mr4078154pfb.212.1570014005072;
        Wed, 02 Oct 2019 04:00:05 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id r28sm22102381pfg.62.2019.10.02.04.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 04:00:04 -0700 (PDT)
Date:   Wed, 2 Oct 2019 18:59:59 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/2] common/defrag: support f2fs
Message-ID: <20191002105956.GZ2622@desktop>
References: <20190927100627.9086-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927100627.9086-1-yuchao0@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Sep 27, 2019 at 06:06:26PM +0800, Chao Yu wrote:
> F2FS supports defragment based on file granularity, adjust test suit
> to support f2fs.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  common/config |  2 ++
>  common/defrag | 11 ++++++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/common/config b/common/config
> index 4c86a492..c43be339 100644
> --- a/common/config
> +++ b/common/config
> @@ -176,6 +176,7 @@ export XFS_COPY_PROG="$(type -P xfs_copy)"
>  export FSTRIM_PROG="$(type -P fstrim)"
>  export DUMPE2FS_PROG="$(type -P dumpe2fs)"
>  export RESIZE2FS_PROG="$(type -P resize2fs)"
> +export F2FS_IO_PROG="$(type -P f2fs_io)"
>  export FIO_PROG="$(type -P fio)"
>  export FILEFRAG_PROG="$(type -P filefrag)"
>  export E4DEFRAG_PROG="$(type -P e4defrag)"
> @@ -240,6 +241,7 @@ case "$HOSTOS" in
>  	export MKFS_BTRFS_PROG=$(set_mkfs_prog_path_with_opts btrfs)
>  	export MKFS_F2FS_PROG=$(set_mkfs_prog_path_with_opts f2fs)
>  	export DUMP_F2FS_PROG=$(type -P dump.f2fs)
> +	export F2FS_IO_PROG=$(type -P f2fs_io)
>  	export BTRFS_UTIL_PROG=$(type -P btrfs)
>  	export BTRFS_SHOW_SUPER_PROG=$(type -P btrfs-show-super)
>  	export BTRFS_CONVERT_PROG=$(type -P btrfs-convert)
> diff --git a/common/defrag b/common/defrag
> index 2bd739c0..9866d3da 100644
> --- a/common/defrag
> +++ b/common/defrag
> @@ -27,6 +27,9 @@ _require_defrag()
>  	rm -f $testfile $donorfile 2>&1 > /dev/null
>  	DEFRAG_PROG="$E4DEFRAG_PROG"
>  	;;
> +    f2fs)
> +	DEFRAG_PROG="$F2FS_IO_PROG defrag_file"
> +	;;
>      btrfs)
>  	DEFRAG_PROG="$BTRFS_UTIL_PROG filesystem defragment"
>  	;;
> @@ -140,7 +143,13 @@ _defrag()
>  
>  	[ ! -z $csum ] && CSUM_BEFORE=`md5sum $1`
>  	STAT_BEFORE=`stat -c "a: %x m: %y c: %z" $1`
> -	$DEFRAG_PROG -v $1 >> $seqres.full 2>&1
> +
> +	if [ $FSTYP == "f2fs" ]; then
> +		_filesize=`ls -l $1 | $AWK_PROG '{print $5}'`

Better to declare "filesize" as a local variable here.

		local filesize=`stat -c %s $1`

Otherwise looks fine to me.

But it'd be better to let other f2fs developers review this patchset as
well.

Thanks,
Eryu

> +		$DEFRAG_PROG 0 $_filesize $1 >> $seqres.full 2>&1
> +	else
> +		$DEFRAG_PROG -v $1 >> $seqres.full 2>&1
> +	fi
>  
>  	_scratch_cycle_mount
>  	STAT_AFTER=`stat -c "a: %x m: %y c: %z" $1`
> -- 
> 2.18.0.rc1
> 
