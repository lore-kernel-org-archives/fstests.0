Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A9B29CE1
	for <fstests@vger.kernel.org>; Sat,  2 May 2026 02:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777687913; cv=none; b=i4ijTc2K3NvUPitZl+NRpgG3p66HhBXcbYL5iK4k9P0o83dBfyrQqvjaR/XpESpUsjDORRW/iY69Vq12XjeR9x77aNgIRmmNYaWet9wFwPQ+TlwTaUBkHMn9HEe4DnI5EwgV6k0r8NHZGhVdOQi5I+ninifOqt8aVXnUtUNvsEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777687913; c=relaxed/simple;
	bh=+35PStDJgkrtqTvRRHRCRpCJSGv6AsaILkRdM2RRolI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjYULBeyAtDnPTKBs8rG3IORDtt84h8T45oFATx/PXzXYHxTnKNmQwgOiejxUXb7b4WkgFATxNrAlMKSartpnhLAlH7OgEgLxM/fkveUh+0XFtC77dl4iDw6emePuLhm+GN9XwNou9uCfJWnYN2LVVI0Cb1T3nmePwgJE2HkIKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Al65P6SX; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Al65P6SX"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-356337f058aso1562686a91.2
        for <fstests@vger.kernel.org>; Fri, 01 May 2026 19:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777687912; x=1778292712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEjq7D6SQbjq+dm80J2m8C0/q5ysRjrTj0T2q4jFV9Q=;
        b=Al65P6SX6DuN+9kwgNQgFp6DCtWacmLWfarqPf/45dZ9eZjFs9fOr+JHpnvmbENK9y
         dECOoQ8+7xn1g5sdG6JWjwXU0ea/LPUT3+oAZ3yjCLz+NW3lFj/QiXm9EKgdOnY6Nuiu
         LLco++prmts7u3BrERR2VxjYrfolf0z2rCUDPhZAw3L2uwkZPu8BTrk3Qqy1dMqnUJzV
         p7uolPxAE3H5wokREh8VrKWU3TQFwHAZrDz7ir26s6PyeUidYdzDXiU2i6iYqgO1yYnw
         7Di/pMUwF0rzNebxJZKpvMGR7pX195Bwu+OAh4yrmru1p6x37zf11ejTjiobhHrgAyE2
         Y8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777687912; x=1778292712;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jEjq7D6SQbjq+dm80J2m8C0/q5ysRjrTj0T2q4jFV9Q=;
        b=WfHoKucBK3Hc2ZG+20JpEq7OMYxEKJ/U2T7UPbvVJzPFBnodOM7GiI37jzx0XNdqvi
         z4iZC63hAsFuABRLu41PGi7zERYGaGPGzsesySo3b5BaJnEB/9yJWTwwvoWEbCz0n8Wt
         J1rNWdtVrh9PqL68vIVD3Vsdxl5e64j1WKiNzIx73ljGeW7gXIEVbS+KJJeMkkZYQ0/f
         MR3/ZB9nfPtZitF8qtapwCcJA59onRsRS03LLVQI564RurVVJ1Va6VjfjpTcVgI/lPlW
         r3+VUFU4tAdxFpV02X6KIEjiskgC04Bn8UdLfBAiYDKBP9OdOJr+i44yN8FlYxtWWure
         AYLg==
X-Gm-Message-State: AOJu0Yxrvbx6lMODzsKNJPsLzFc/YEqK7YZLwALcYN8D0zym3npkLmSK
	3Md2imoRctnaXEYNIcCz1frXSQEF5xniTL4bVA7rrURXktS5lbWiRYD0nu0js9zdrzY=
X-Gm-Gg: AeBDievGvV9uhNMhbgrIw8j8xdsGAb1Tgqq61TlmJ4MuxaHrD0oY2Rq0yllxht0nPyR
	H7ncRrV4baH+Gf/pVLGpSEcg8LPDz2hwuy1nWedfvGtYZXxDy6IZtOlxBv45SnLlBZYHNdCBKSZ
	8x1YNTFPG3av2NZGHP6W7fICySFnfHRFB/XRDxw1DyT0iIVGpJOoSp/lqu+2Xk1xkB2GTvpE9Pt
	84bXi+nzind7rxhPp1OygyeDtTx/DixvV+4naztrOUZx0PEyIM+8FMdxv5aIEb0oiDIMR2Shlue
	V53XT2rS4pirKaZrwq3G/0Bc+bM5qF93r63W78AtBMJq1Y2yt/aF/eaGWyz0+5kj8SYfXuPpvri
	bWpbrtwhqoleZ5uYlJ5UNNByD6MU5kwrl1Vz19XbNl+zfMnOy+1ckQ9h36Ika/1jzuEwe/z/7Nq
	nE/adjrOnbjGLGk9Q9DtE5Csqtv2FdXzs=
X-Received: by 2002:a17:90b:2b45:b0:361:423d:2026 with SMTP id 98e67ed59e1d1-3650cdbcabfmr1488200a91.12.1777687911702;
        Fri, 01 May 2026 19:11:51 -0700 (PDT)
Received: from zlang-mailbox ([218.69.128.26])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebd46484sm4877913a91.0.2026.05.01.19.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 19:11:51 -0700 (PDT)
From: Zorro Lang <zorro.lang@gmail.com>
X-Google-Original-From: Zorro Lang <zlang@kernel.org>
Date: Sat, 2 May 2026 10:11:45 +0800
To: Joanne Chang <joannechien@google.com>
Cc: fstests@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, 
	linux-f2fs-devel@lists.sourceforge.net, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v1] f2fs/{022,023}: clear MOUNT_OPTIONS alongside
 MKFS_OPTIONS
Message-ID: <afVc-ZxMAKHCpQSR@zlang-mailbox>
Mail-Followup-To: Joanne Chang <joannechien@google.com>, 
	fstests@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, 
	linux-f2fs-devel@lists.sourceforge.net, Chao Yu <chao@kernel.org>
References: <20260428022440.2481342-1-joannechien@google.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428022440.2481342-1-joannechien@google.com>

On Tue, Apr 28, 2026 at 02:24:40AM +0000, Joanne Chang wrote:
> Currently, f2fs/022 and f2fs/023 only clears MKFS_OPTIONS. This causes
> the tests to fail when leftover MOUNT_OPTIONS depend on unapplied
> MKFS_OPTIONS. So MOUNT_OPTIONS should also be cleared to ensure reliable
> mounting.
> 
> Signed-off-by: Joanne Chang <joannechien@google.com>
> ---

Hmm, Makes sense to me.

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  tests/f2fs/022 | 1 +
>  tests/f2fs/023 | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/tests/f2fs/022 b/tests/f2fs/022
> index 728ef4e8..854ec327 100755
> --- a/tests/f2fs/022
> +++ b/tests/f2fs/022
> @@ -23,6 +23,7 @@ _require_inject_f2fs_command node i_nid
>  
>  # remove all mkfs options to avoid layout change of on-disk inode
>  export MKFS_OPTIONS=""
> +export MOUNT_OPTIONS=""
>  
>  foo_path=$SCRATCH_MNT/foo
>  bar_path=$SCRATCH_MNT/bar
> diff --git a/tests/f2fs/023 b/tests/f2fs/023
> index 33108421..f3e8785f 100755
> --- a/tests/f2fs/023
> +++ b/tests/f2fs/023
> @@ -25,6 +25,7 @@ testfile=$SCRATCH_MNT/testfile
>  
>  # remove all mkfs options to avoid layout change of on-disk inode
>  export MKFS_OPTIONS=""
> +export MOUNT_OPTIONS=""
>  
>  _scratch_mkfs "-O extra_attr,flexible_inline_xattr" >> $seqres.full || _fail "mkfs failed"
>  _scratch_mount "-o inline_xattr_size=512" >>$seqres.full 2>&1
> -- 
> 2.54.0.rc2.544.gc7ae2d5bb8-goog
> 
