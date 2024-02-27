Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175BF4CB2B
	for <fstests@vger.kernel.org>; Tue, 27 Feb 2024 04:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709006698; cv=none; b=A4UGZ9F76h9vQlMBSat7epCYwKmmk5QgOYZSQAHUGEjvjWLgajOm+BQYCK2KisywwjqjyViqPGT47ofRvYoHA02lM0rjYtJVQX39KfegOa/EScAspbTssKQUnpZvh4euxQ0cRSKgG21n7n7Shgees57QRh2ldSzyqGkUx7RbTcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709006698; c=relaxed/simple;
	bh=kLAfyK9mrCzp/rMDLNLBBtuyirjdXlsmzHb7eMYJjJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDyb8qIiK+gEaaXR4Sus+QGBgRFZeaFUQmNv+FnxNoiVkuTrw0kk1d2i9/un+wTMgX0I/ea0EC6wFKquJG7K9VIn/eR0KGMxl24I0kLO0hAkEmBIS/TPiCYDl6HI0bOMKyXa32rd5cRSTyLHePtJqhPMFFQiCejjI5E3ZZOizjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fc4WK3JW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fc4WK3JW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709006695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bpalOVGcYt0wk+s5tAlawFpB6IZ/lM/9vhDAF5IbyFY=;
	b=Fc4WK3JW0SUYkt2DK+TjHPwXhu6h15MOe119dDb8W5j+X/u54KKvCAHjbqR0q6yMxa/twe
	Ewg/fjqYQP2Exx0mHy0kgrEYiqrddMhnWIRpGeVTr1XYuAiH5ntuxZnrJws+oWlI6RWpA1
	jnhIBcJ3Aw6NNA/anNvNDrayqCbFwKE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-i_aVE7k1Nz-m-jn0cE9NJQ-1; Mon, 26 Feb 2024 23:04:53 -0500
X-MC-Unique: i_aVE7k1Nz-m-jn0cE9NJQ-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1dbb69acd6aso37871285ad.2
        for <fstests@vger.kernel.org>; Mon, 26 Feb 2024 20:04:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709006693; x=1709611493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpalOVGcYt0wk+s5tAlawFpB6IZ/lM/9vhDAF5IbyFY=;
        b=MQOQNCruARp0oILHG9p0gW4+qEhoYoFFtp4HnLawVrfgdZowzPhnsXhb79YnlU5trN
         sUJ1NYYBUaPB0FpWYB9H/zRoBx0gMTidv01Z/PDpgKwfm04JzXhYLq35rPaB64BRQiXi
         1vqbh5lxD3jUPUQVelz1pjV4E1qpIQaacusE6Ywx1Xgd/ETh1PcPlDMlpsj/0EAMTYi7
         x7zglE5LSvCtClO3cIu3DBygWEfVsXw+5wuYXjdgpPOfIax/81xc3Z1QGSBcRzLB6Xqz
         uHBRa1lXjN21tCzn0QgMi/afRVFOgUe4+LrMXx8cbKP7YEfbr4ufQdYoSY8fEzG+t0ZL
         CcyA==
X-Forwarded-Encrypted: i=1; AJvYcCXVRPV0Ue9T91Pd0F5LdL7A2kF9LPCMi3ixTaHYyVLBNU/aLyOi6oe1+YMg6ylQqH1bgnampeMg1X1KeKVrZkUbUo0F/StUJg==
X-Gm-Message-State: AOJu0YzZm9QYz4UdEYHOQf9PB/9k43R1Vk9E/f+PzmS8vGrPkS8R5zwo
	ytF7eomvF5ol8LlWzBDYdKghhk76Q1NDeTewcBal5QDtnBmczdO8qB0HxXyJTwppuv6f/Z9lUd5
	BAHf0zeI9GOtr/ZtP8+se8/7PWUEyvIGAsF4C0KnlN2qscZ7HeHoJ+qo=
X-Received: by 2002:a17:902:d4c8:b0:1db:a94f:903d with SMTP id o8-20020a170902d4c800b001dba94f903dmr9836243plg.36.1709006692798;
        Mon, 26 Feb 2024 20:04:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFi48FiE+Edmw0dQ934qmNymR/Z/DtiuVPE2xpF6u6uTU6u6CiPjKaZiCpHQVxYiduAKuxnQ==
X-Received: by 2002:a17:902:d4c8:b0:1db:a94f:903d with SMTP id o8-20020a170902d4c800b001dba94f903dmr9836235plg.36.1709006692448;
        Mon, 26 Feb 2024 20:04:52 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jv3-20020a170903058300b001dc71ead7e5sm449925plb.165.2024.02.26.20.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 20:04:52 -0800 (PST)
Date: Tue, 27 Feb 2024 12:04:49 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/8] generic/604: try to make race occur reliably
Message-ID: <20240227040449.6qvvdk2k6bzoy6pr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <170899915207.896550.7285890351450610430.stgit@frogsfrogsfrogs>
 <170899915233.896550.17140520436176386775.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170899915233.896550.17140520436176386775.stgit@frogsfrogsfrogs>

On Mon, Feb 26, 2024 at 06:00:47PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This test will occasionaly fail like so:
> 
> --- /tmp/fstests/tests/generic/604.out	2024-02-03 12:08:52.349924277 -0800
> +++ /var/tmp/fstests/generic/604.out.bad	2024-02-05 04:35:55.020000000 -0800
> @@ -1,2 +1,5 @@
>  QA output created by 604
> -Silence is golden
> +mount: /opt: /dev/sda4 already mounted on /opt.
> +       dmesg(1) may have more information after failed mount system call.
> +mount -o usrquota,grpquota,prjquota, /dev/sda4 /opt failed
> +(see /var/tmp/fstests/generic/604.full for details)
> 
> As far as I can tell, the cause of this seems to be _scratch_mount
> getting forked and exec'd before the backgrounded umount process has a
> chance to enter the kernel.  When this occurs, the mount() system call
> will return -EBUSY because this isn't an attempt to make a bind mount.
> Slow things down slightly by stalling the mount by 10ms.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/generic/604 |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> 
> diff --git a/tests/generic/604 b/tests/generic/604
> index cc6a4b214f..a0dcdcd58e 100755
> --- a/tests/generic/604
> +++ b/tests/generic/604
> @@ -24,10 +24,11 @@ _scratch_mount
>  for i in $(seq 0 500); do
>  	$XFS_IO_PROG -f -c "pwrite 0 4K" $SCRATCH_MNT/$i >/dev/null
>  done
> -# For overlayfs, avoid unmouting the base fs after _scratch_mount
> -# tries to mount the base fs
> +# For overlayfs, avoid unmouting the base fs after _scratch_mount tries to
> +# mount the base fs.  Delay the mount attempt by 0.1s in the hope that the
> +# mount() call will try to lock s_umount /after/ umount has already taken it.
>  $UMOUNT_PROG $SCRATCH_MNT &
> -_scratch_mount
> +sleep 0.01s ; _scratch_mount

0.1s or 0.01s ? Above comment says 0.1s, but it sleeps 0.01s actually :)

The comment of g/604 says "Evicting dirty inodes can take a long time during
umount." So how long time makes sense, how long is the bug?

Thanks,
Zorro

>  wait
>  
>  echo "Silence is golden"
> 

