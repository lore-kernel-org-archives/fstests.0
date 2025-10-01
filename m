Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4D82C2368
	for <fstests@vger.kernel.org>; Wed,  1 Oct 2025 06:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299891; cv=none; b=jUH/2Bnt8PE8liSg+g+NdK4PJOLvDwTxgJQlF+pWVfRyeiDWpVV64td4yCMgCHvxI3X3wj7QjGgOh0uqmzwpa9cpV/ts1ouk94xtNPtJP/zViDNMOFguijVC2EDQZqvgfPQtZSRAKZj0YCRirXvmFftqJ2YI/beBqb4qhQma6Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299891; c=relaxed/simple;
	bh=pzKF3r57pffVZaFu1yce05x47J2elKx5lKzf8lfhSiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbbRYyL7f6P63vF6jgR8BsG/fFBiwG3iIp0NAekoPMszQxsnSpPGBOGJhnnsauLMtXBhudv4hvAwHRaBzxpAhfSit+irTMRIylidSnbbY9vSN4qGJtVkiVR667q8NZHAwg7dBsJmj2V8NHUYHqFR/2vdICf/J7xKwMBzXkblTks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CfHbaQTr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CfHbaQTr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759299889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A+0i3l0iDuYL4y4gHFhoKOCgirARm5a/sSYRjGIchxs=;
	b=CfHbaQTr1RR9gMM2lFG9BpCMZmiR9gvp8G8I/neo8vh8l9y3t1sopsMJwJG8mR30SADmnW
	lZ0zm6AV6k9zUg3sK6GnqauCOMNibNrhOm68v/NQPZKz1qDeGMPgyfTgYX/WKOKq0FbmRQ
	ERV4/JaO3xd0PwpMimAIt428fYbxBqw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-wOasL5zBORa6XNkmhh2ocQ-1; Wed, 01 Oct 2025 02:24:48 -0400
X-MC-Unique: wOasL5zBORa6XNkmhh2ocQ-1
X-Mimecast-MFC-AGG-ID: wOasL5zBORa6XNkmhh2ocQ_1759299887
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-783604212ebso6829023b3a.3
        for <fstests@vger.kernel.org>; Tue, 30 Sep 2025 23:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759299887; x=1759904687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+0i3l0iDuYL4y4gHFhoKOCgirARm5a/sSYRjGIchxs=;
        b=KEjNBZe5jT6rWfwsdgdFGc+TsxC3XkKhvHUcNby43tW93NOndbtlYCNJA8MF2M+INK
         nAVjtfcTJ9fJwWCKq14uqBNpvPyiTPxP+klvqS5wEO6Fl4zMDejO4ZECAw4QoiSzZrb7
         f0NO8h4sBH8L9wtdsB/yFt7PlqXqM9UHfEsDchfEp1UPOJRnDteNroNiu1AmmHvRQdyy
         JbI2eLdUnIljCvPeHiTNdycm2qN2rWh/6KKvm2qYvGRbcni5yYajpCEPs4yrwQYhL03D
         zG7O68/fWl2/aZJ+xN8LrbB0hDtxfBMMvjeG7TxC4puA8IATWiRWXy/2W8+Y+5NtjVPZ
         sulg==
X-Forwarded-Encrypted: i=1; AJvYcCVCrIFeU2NVWdb2D6p/LXE2RzYyS+2hXWRKrn+ackVFmyxAuym6DqXznZoSeNJn7nITE4m8mizr@vger.kernel.org
X-Gm-Message-State: AOJu0YxRc130ILuwBsV2BJo+TeSrP8eHGBVxvHngCmxfVIDI9IVYSZa0
	EmpOrpl/JjX8p0omq/gSLSy4xa+krpoPsdDQvsYFv3h3BHhtbjoaOY25n8BUU2jWBVXUH70d0VY
	kmKIh540MaI+A44XyeCexlPTr/Gd7V4lWUnnTLvUp430iTMeqYtQlSINuhbM=
X-Gm-Gg: ASbGncvPBsxIom3NmvhAtsfUKV0VM0ZaIv81aM5RG6liBgVdVTSPNJEy+IeI5sH4+Z+
	292v3306dSdullxju+7Hp5VBks5khnyy9FcWqDkxTBagX2XyXTHKpU4hwUsxMPRmU+77CEJf2yn
	QZcShTaPvBRFusSbISFMpwmwJeQ/OPawnABZnDdX79OHAEewm9C+Y3+k1itHdoq0fLAitbc16cY
	i5IdTG8LpMcIpq0bLH9BlZInPd4Ob2kGcg5M+GE+wP8plKBhVKg/BVh3nHidT3iZjoT2JOHt2HP
	7dOECo1hwnXel1gjYsf0q6TsyCL9Goy55uZ3xeRuxKY6laT69DmrAmWYrLRPBP8MyLNw0iCvMp/
	uV7TAwE0Htw==
X-Received: by 2002:a05:6a00:3d4b:b0:781:2177:1c9b with SMTP id d2e1a72fcca58-78af4160670mr2964935b3a.17.1759299886923;
        Tue, 30 Sep 2025 23:24:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/f+ttRWlC8JRPXV++DICR2wJGnZzlG+koVtdjKREiAEJg2hgZ8DtqqRlJ3eaT4Ep40zg/Dg==
X-Received: by 2002:a05:6a00:3d4b:b0:781:2177:1c9b with SMTP id d2e1a72fcca58-78af4160670mr2964896b3a.17.1759299886360;
        Tue, 30 Sep 2025 23:24:46 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238cdd1sm15241810b3a.3.2025.09.30.23.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 23:24:45 -0700 (PDT)
Date: Wed, 1 Oct 2025 14:24:41 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] common/f2fs: introduce _require_inject_f2fs_command()
Message-ID: <20251001062441.cjh2wd7uleduehey@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250928185240.57862-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928185240.57862-1-chao@kernel.org>

On Mon, Sep 29, 2025 at 02:52:40AM +0800, Chao Yu wrote:
> Introduce _require_inject_f2fs_command() to check whether inject.f2fs
> supports specific metaarea and member parameters.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  common/f2fs    | 25 +++++++++++++++++++++++++
>  tests/f2fs/009 |  2 ++
>  tests/f2fs/012 |  2 ++
>  tests/f2fs/019 |  2 ++
>  tests/f2fs/020 |  2 ++
>  tests/f2fs/022 |  2 ++
>  6 files changed, 35 insertions(+)
> 
> diff --git a/common/f2fs b/common/f2fs

You remind me that there's a common/f2fs file, you can move f2fs specific
functions to common/f2fs (e.g. _check_f2fs_filesystem) later :)

> index 1b39d8ce..4b01e032 100644
> --- a/common/f2fs
> +++ b/common/f2fs
> @@ -25,3 +25,28 @@ _require_scratch_f2fs_compression()
>  		_scratch_unmount
>  	fi
>  }
> +
> +# check that inject.f2fs supports to inject specific field in specific meta area
> +_require_inject_f2fs_command()
> +{
> +	if [ $# -ne 2 ]; then
> +		echo "Usage: _require_inject_f2fs_command metaarea member" 1>&2
> +		_exit 1
> +	fi
> +	metaarea=$1
> +	member=$2
> +
> +	case $metaarea in
> +	sb|cp|nat|sit)
> +		val=0
> +		;;
> +	ssa|node|dent)
> +		;;
> +	*)
> +		_notrun "unsupport metaarea: $metaarea"
> +		;;
> +	esac
> +
> +	$F2FS_INJECT_PROG "--$metaarea" "$val" "-h" | grep "$member:" > /dev/null || \
> +		_notrun "--$metaarea --mb $member support is missing"
> +}
> diff --git a/tests/f2fs/009 b/tests/f2fs/009
> index 7333d484..465be874 100755
> --- a/tests/f2fs/009
> +++ b/tests/f2fs/009
> @@ -9,10 +9,12 @@
>  # and expects fsck.f2fs can detect such corruption and do the repair.
>  #
>  . ./common/preamble
> +. ./common/f2fs

The common/f2fs can be imported by common/config:_source_specific_fs()
automatically, so we don't need this line at here.

(Same below)

>  _begin_fstest auto quick
>  
>  _require_scratch
>  _require_command "$F2FS_INJECT_PROG" inject.f2fs
> +_require_inject_f2fs_command node i_links

If the "_require_command $F2FS_INJECT_PROG inject.f2fs" is always required
before _require_inject_f2fs_command, how about call it at the beginning
of _require_inject_f2fs_command ?

(same below)

Thanks,
Zorro

>  _require_command "$(type -P socket)" socket
>  
>  _fixed_by_git_commit f2fs-tools 958cd6e \
> diff --git a/tests/f2fs/012 b/tests/f2fs/012
> index 7438d9ce..8e156772 100755
> --- a/tests/f2fs/012
> +++ b/tests/f2fs/012
> @@ -12,6 +12,7 @@
>  # 4.enable linear lookup, expect lookup succeed
>  #
>  . ./common/preamble
> +. ./common/f2fs
>  _begin_fstest auto quick casefold
>  
>  _fixed_by_kernel_commit 91b587ba79e1 \
> @@ -21,6 +22,7 @@ export LC_ALL=C.UTF-8
>  _require_scratch_nocheck
>  _require_command "$F2FS_IO_PROG" f2fs_io
>  _require_command "$F2FS_INJECT_PROG" inject.f2fs
> +_require_inject_f2fs_command dent d_hash
>  
>  #check whether f2fs supports "lookup_mode=x" mount option
>  mntopt=""
> diff --git a/tests/f2fs/019 b/tests/f2fs/019
> index 2307bd96..f6bb0b52 100755
> --- a/tests/f2fs/019
> +++ b/tests/f2fs/019
> @@ -12,6 +12,7 @@
>  #    corruption in the file
>  #
>  . ./common/preamble
> +. ./common/f2fs
>  _begin_fstest auto quick rw
>  
>  _fixed_by_kernel_commit 77de19b6867f \
> @@ -19,6 +20,7 @@ _fixed_by_kernel_commit 77de19b6867f \
>  
>  _require_scratch_nocheck
>  _require_command "$F2FS_INJECT_PROG" inject.f2fs
> +_require_inject_f2fs_command node addr
>  
>  # remove all mkfs options to avoid layout change of on-disk inode
>  export MKFS_OPTIONS=""
> diff --git a/tests/f2fs/020 b/tests/f2fs/020
> index 38bc6582..332848d0 100755
> --- a/tests/f2fs/020
> +++ b/tests/f2fs/020
> @@ -12,6 +12,7 @@
>  #    corruption in the file
>  #
>  . ./common/preamble
> +. ./common/f2fs
>  _begin_fstest auto quick rw
>  
>  . ./common/attr
> @@ -21,6 +22,7 @@ _fixed_by_kernel_commit 061cf3a84bde \
>  
>  _require_scratch_nocheck
>  _require_command "$F2FS_INJECT_PROG" inject.f2fs
> +_require_inject_f2fs_command node i_xattr_nid
>  _require_attrs user
>  
>  # remove all mkfs options to avoid layout change of on-disk inode
> diff --git a/tests/f2fs/022 b/tests/f2fs/022
> index ed3b4f2b..f81180e8 100755
> --- a/tests/f2fs/022
> +++ b/tests/f2fs/022
> @@ -11,6 +11,7 @@
>  # 4. fpunch in foo w/ specified range
>  #
>  . ./common/preamble
> +. ./common/f2fs
>  _begin_fstest auto quick rw
>  
>  . ./common/attr
> @@ -20,6 +21,7 @@ _fixed_by_kernel_commit xxxxxxxxxxxx \
>  
>  _require_scratch_nocheck
>  _require_command "$F2FS_INJECT_PROG" inject.f2fs
> +_require_inject_f2fs_command node i_nid
>  
>  # remove all mkfs options to avoid layout change of on-disk inode
>  export MKFS_OPTIONS=""
> -- 
> 2.40.1
> 

