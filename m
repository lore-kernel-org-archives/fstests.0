Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0042E62B7
	for <fstests@vger.kernel.org>; Fri, 13 Mar 2026 19:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773431167; cv=none; b=XwCv99DyAoQRhyl3jopzvoquBCZ2PyhNGOIT9TUNcBT7i9dXv4SIgaoqkAPqKa3MxNcMzAyMsV44qrHXgzHVJIiKErMosIYg9LQShwbWybNwsznzrTc4E3yleNjbBHPwQbU+AFaY1ra0dxy1uIg5onA/DJz1J2TLtiujKNOQrUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773431167; c=relaxed/simple;
	bh=U4TJIo4d3y6APZkq1LXnPdiX0plhxNz0tNj8VmONZ4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDMA6NFvll5FpnBgjDzVOylpVJm4YwFrAYqd4u91S10AAUtzbjtDVt9W0eoSqLVsQykHOkbuUoFjrLpzsSs18rqJUsYBQ8teFELg5DeJqtNsR0XoIRvOgghIg2BZF/1DE0V/RPa1RdujYC4spVfQx8X+npqhwIagL81SSeXAlrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DGKtpcWy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M+M9qsUE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGKtpcWy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+M9qsUE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773431165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3+UJalBt8ooxFAmXhAHDE6Cv2mDVNMgTscGv8utLjlQ=;
	b=DGKtpcWyqZ+2GKhTaKwSdlUP6fpf/1Z+XV3lW6pyIM2YH8cd/M//h7FUlXYZJ5FNCokm9p
	wSVLg9pGyiPPNRrRqrcV1qfD6vWLxIMntF147Ru0+pDB6rJiB26adJmB3ukdkETQPTGGhJ
	GAMOpNrKcVc+w1TwrX9jVGsjNJZwePM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-ZJiVwyI_OKuxAYC7eq8rvw-1; Fri, 13 Mar 2026 15:46:03 -0400
X-MC-Unique: ZJiVwyI_OKuxAYC7eq8rvw-1
X-Mimecast-MFC-AGG-ID: ZJiVwyI_OKuxAYC7eq8rvw_1773431162
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35845fcf0f5so3001146a91.0
        for <fstests@vger.kernel.org>; Fri, 13 Mar 2026 12:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773431162; x=1774035962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3+UJalBt8ooxFAmXhAHDE6Cv2mDVNMgTscGv8utLjlQ=;
        b=M+M9qsUEw7izdj96pyedykVaSoOy9ZueJ0LqJRitc0eEDKmsHd6NcRVUFGatRLONAu
         BiS5aDhq+ViAzVGxUiAKSkLa7UfdRbHcGqRujqw4SaqZfEcObPv+inXwLifBWVAFHY4A
         kIx7/5dtAQ7+iKLAyIxHtpek43vkdexMqy8nGdKXhxnBjeV1kRL2keM6AfF6t6tJEH6F
         +YaOwt0FSAugiOW1AT5H+cOtVppvnXtTUQEhLMHFrfY+HMjD134JN9e6u34wmgvI89dQ
         RbWW1euUmjZCvs8xuJKLjl8heQzD8Ll5DAbhmJWBMB127f7OWLTW9Scs5UE8FQoqraUU
         SNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773431162; x=1774035962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+UJalBt8ooxFAmXhAHDE6Cv2mDVNMgTscGv8utLjlQ=;
        b=AB5XuXY63xizZS6MbCuj12Gez2mYzIN4UIKsj0VHSnCongS60OI0Ux21njMkSfR3En
         VTKRvK3VoSrI4XM9pFKDXBu+9hKjg3bRGwvZjWKuKw2cSxHqrz6m4YW4jLFf+bjoqPNp
         HZr6ZXBUcCRBhecHGrYuP5KyJKg9ut/p2FlbmnXiDgpyIIoZg1fbQibIE2dFm4oIK1ss
         EzJbHuaep2j0HbrqArC4IedRi06G/4UwdvaFY4LkYRfxabytOpqdSC5sYP5zbsezcUYy
         mD1dWMcWHMaaMq1Fibyg0qz81VqHNEij/22mTybpb5y2ubxw6pk8mqL9ULs3y1zNk3EC
         8yNA==
X-Gm-Message-State: AOJu0Yw1z3MQ8jK0B50UIYinVoT7IyHXz6FHb0T5y/GsUsajVq4Wg/ra
	zCN1JA06ikvRJ5E0jdQOYL/DTA3SqMQm91FvKi/4S8khwsfwbRrq77DvopqRH759pLP91neLBAo
	84ZSg+A1vrmnBJwoII0+7lfXrLgYMrRcrDum38KgUiVrKXCREQsVxqByGadP17BJfdf8=
X-Gm-Gg: ATEYQzx7qHBkSerzXs/bWoxJjrbRi3X1858Nyh1gm3sxQv3PhSe3mJK1BcDU6dkwCaD
	AJ3SyaIv6yjfcSfNVEFbRf+UhvrEY1hRkSivaacTMyxXcKpCH4eHwo8gEGL6Pevd5aP6AJaXWW3
	yzEeqDosfYOhgjRH6vVqqKojixABY+z7a8MbeEgBuAkft4Lclyl1VrOwkDHFw/qKpqwzDbQgpbG
	iKH9swDw0R4uEBC6K7n2tDvMpaZ95BoarJup0q3oXO8Mrk8zTFyX2V6I8zG1xe1SCS9BI/pKWxt
	5Caf/nZRjK4Khba+4Ei+YcpKN5LIi0B7qotGD1e4fqFxm8O7zPqn8yICc1/Z5bte1yr/ayLaKhx
	o9+IwF5VPqCyiw1RAEMdkM0jhtWKnJAl1kvgZiDUwCmqppOzxcOPC/NYxQhGQVg==
X-Received: by 2002:a17:90b:4a47:b0:34a:be93:72ee with SMTP id 98e67ed59e1d1-35a21ec604bmr3647706a91.8.1773431161944;
        Fri, 13 Mar 2026 12:46:01 -0700 (PDT)
X-Received: by 2002:a17:90b:4a47:b0:34a:be93:72ee with SMTP id 98e67ed59e1d1-35a21ec604bmr3647692a91.8.1773431161510;
        Fri, 13 Mar 2026 12:46:01 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a03005f7fsm9235905a91.15.2026.03.13.12.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 12:46:01 -0700 (PDT)
Date: Sat, 14 Mar 2026 03:45:57 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 09/14] xfs: test xfs_healer can report filesystem
 shutdowns
Message-ID: <20260313194557.or7abafu4ctzsm4t@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <177311403712.1186408.7032564474004561606.stgit@frogsfrogsfrogs>
 <177311403941.1186408.2309881878313608797.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177311403941.1186408.2309881878313608797.stgit@frogsfrogsfrogs>

On Mon, Mar 09, 2026 at 08:52:28PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Make sure that xfs_healer can actually report abnormal filesystem shutdowns.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---

Tests and looks good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/1898     |   37 +++++++++++++++++++++++++++++++++++++
>  tests/xfs/1898.out |    4 ++++
>  2 files changed, 41 insertions(+)
>  create mode 100755 tests/xfs/1898
>  create mode 100755 tests/xfs/1898.out
> 
> 
> diff --git a/tests/xfs/1898 b/tests/xfs/1898
> new file mode 100755
> index 00000000000000..2b6c72093e7021
> --- /dev/null
> +++ b/tests/xfs/1898
> @@ -0,0 +1,37 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2024-2026 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test No. 1898
> +#
> +# Check that xfs_healer can report filesystem shutdowns.
> +
> +. ./common/preamble
> +_begin_fstest auto quick scrub eio selfhealing
> +
> +. ./common/fuzzy
> +. ./common/filter
> +. ./common/systemd
> +
> +_require_scratch_nocheck
> +_require_scrub
> +_require_command "$XFS_HEALER_PROG" "xfs_healer"
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount
> +_require_xfs_healer $SCRATCH_MNT
> +$XFS_IO_PROG -f -c "pwrite -S 0x58 0 500k" -c "fsync" $victim >> $seqres.full
> +
> +echo "Start healer and shut down"
> +_scratch_invoke_xfs_healer "$tmp.healer"
> +_scratch_shutdown -f
> +
> +# Unmount filesystem to start fresh
> +echo "Kill healer"
> +_scratch_kill_xfs_healer
> +cat $tmp.healer >> $seqres.full
> +cat $tmp.healer | _filter_scratch | grep 'shut down'
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/1898.out b/tests/xfs/1898.out
> new file mode 100755
> index 00000000000000..f71f848da810ce
> --- /dev/null
> +++ b/tests/xfs/1898.out
> @@ -0,0 +1,4 @@
> +QA output created by 1898
> +Start healer and shut down
> +Kill healer
> +SCRATCH_MNT: filesystem shut down due to forced unmount
> 

