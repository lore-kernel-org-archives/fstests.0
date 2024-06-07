Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68151B806
	for <fstests@vger.kernel.org>; Fri,  7 Jun 2024 04:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717735928; cv=none; b=KR9vGJ0vmgxik/xNrmnXXUsKA6473FJenrGNbcwUQH+FKyDAWyczR9G/bFxTBCJmGzjQ9YqEz1vqWcBCJ3+KDo7YX7gL5mDlWrohSjmzfQQDmI28hU18EGHBs6sdznWDzoRGXekbkyPGjEshCFlOJwJkbcznv3F6GAyRnGZpMd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717735928; c=relaxed/simple;
	bh=6t/QLWsFMBvFv1biW0NIWgQgshnAvtFBpxUiATD00x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyj9UcuWH/0H9z6jnZLZlrme1KTRKjPuiXzGHs0XKfF+aTT/j9VsVdSMCJ/EpojpilCGBq4eoj1ronarcWnBefVMjom9tkwSnmRPuyypBO8ED05+kgXuVh+UDmWy332Q1E8/synvYhTgWfART38w2+PB1kv2Sf1IpDmWtE/WTdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LuenPUmo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LuenPUmo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717735925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QkRofOubstuoiUeoD4zmdtYgKvjplCcMy1S1l+f1NxE=;
	b=LuenPUmoALhVW+f2MMLayMw2R2lJx8nf/HOqLvj7MzWXVxHwkW7f460RUm7DwCnXVZ7kUB
	auHmgGWynzHHlo2CJ8D5fJSFuYuzc7jXAk0lpAX0xwJEA9KKtKTrPejqlRb7iLBCaG35t8
	pFsm0PjbAb0cHxmF1FJjW6AkAWToRjE=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-ux8VbEEDMMeWh7kIarpbBQ-1; Fri, 07 Jun 2024 00:52:03 -0400
X-MC-Unique: ux8VbEEDMMeWh7kIarpbBQ-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3d200a9de76so1601980b6e.3
        for <fstests@vger.kernel.org>; Thu, 06 Jun 2024 21:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717735922; x=1718340722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkRofOubstuoiUeoD4zmdtYgKvjplCcMy1S1l+f1NxE=;
        b=Ae5Zxyl9FXdTaXFjGnNilUfjRcMZF5GnXa8PM5CoMFQ7E/WoMksgcMdlViNW1VP5Dt
         m6bZG3yFfvZxbXrDQDxxa2/5tgXf3nQrC6vs7FGk43kolt/m7Va3WbyzwzloJtFJqnLb
         yUzk3F1gnkXvWvz0xG3t2eaqNe36Ye/g5rjedoh9FgXNprAYgxePT7e3yxTnZFSpwW6G
         Y+Mn2rsU/N9vpSE6AuYy6j8hqdCbnEHg0ZohAXOtPkOVgvPOv846fFBmWo/b8N4vVeK5
         b9ONTpCTbPwdrQAcCqR7zla55SjzXK0IIBysLkv/7Ui1rOfup9bmYUfEAu87VkTHr2md
         xZdA==
X-Gm-Message-State: AOJu0Ywqf1vSPp14gAIxJVJHJgc661I7wD8RS1gJ6A02/mqu+XN394qu
	gZL8s1EDC5rbVTutpd5yo0H4Kl0aAQsqTkDHxA22plbz4klgdztHepdcbYAwLZmYN17Vs1CZlxH
	aCPE6m2/2BrIaaCb0SBy17ih1rlNDqJVzRF6zOenVb0q3UXA2RZSMIy5zm00CXlKa49yC
X-Received: by 2002:a05:6808:4191:b0:3c9:6946:584f with SMTP id 5614622812f47-3d210d6a439mr1326839b6e.22.1717735922127;
        Thu, 06 Jun 2024 21:52:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1HyvwNQA/B9wnT/dTzLhWVr4FyL2J0GdJmhunn0uiELdztY2XvmTTz/dU+ClThN+rCKayVg==
X-Received: by 2002:a05:6808:4191:b0:3c9:6946:584f with SMTP id 5614622812f47-3d210d6a439mr1326826b6e.22.1717735921485;
        Thu, 06 Jun 2024 21:52:01 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd4951ffsm1844051b3a.131.2024.06.06.21.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 21:52:01 -0700 (PDT)
Date: Fri, 7 Jun 2024 12:51:56 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/077: ignore errors occurred while accessing the
 filler files
Message-ID: <20240607045156.2alqia4whdmfpgdx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240605163210.18450-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605163210.18450-1-luis.henriques@linux.dev>

On Wed, Jun 05, 2024 at 05:32:10PM +0100, Luis Henriques (SUSE) wrote:
> When looking for data to fill in the filesystem, errors accessing files
> may occur.  This will cause the test to fail as it'll show in the output
> lines such as:
> 
>     du: cannot read directory '/usr/etc/sudoers.d': Permission denied
> 
> Ignoring these errors should be safe, so simply redirecting the stderr of
> 'du' to $seqres.full fixes it.  Unfortunately, this exposed a different
> issue, which was the truncation of the $seqres.full file while copying files
> into the filesystem.  This patch also fixes that.
> 
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>

Makes sense to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

> ---
>  tests/generic/077 | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/generic/077 b/tests/generic/077
> index 2624e88f1456..4d66f1055403 100755
> --- a/tests/generic/077
> +++ b/tests/generic/077
> @@ -12,13 +12,13 @@ _begin_fstest acl attr auto enospc
>  # Something w/ enough data to fill 256M of fs...
>  filler=""
>  [ -d /lib/modules ] && \
> -	[ $(( $(du -h -m /lib/modules | tail -1| cut -f1) * 2 )) -ge 256 ] && \
> +	[ $(( $(du -h -m /lib/modules 2>> $seqres.full | tail -1| cut -f1) * 2 )) -ge 256 ] && \
>  	filler=/lib/modules
>  
>  # fall back in case /lib/modules doesn't exist or smaller
>  [[ -z $filler ]] && \
>  	[ -d /usr ] && \
> -	[ $(( $(du -h -m /usr | tail -1| cut -f1) * 2 )) -ge 256 ] && \
> +	[ $(( $(du -h -m /usr 2>> $seqres.full | tail -1| cut -f1) * 2 )) -ge 256 ] && \
>  	filler=/usr
>  
>  # Override the default cleanup function.
> @@ -58,10 +58,10 @@ echo "*** set default ACL"
>  setfacl -R -dm u:fsgqa:rwx,g::rwx,o::r-x,m::rwx $SCRATCH_MNT/subdir
>  
>  echo "*** populate filesystem, pass #1" | tee -a $seqres.full
> -cp -rf $filler $SCRATCH_MNT/subdir >$seqres.full 2>&1
> +cp -rf $filler $SCRATCH_MNT/subdir >>$seqres.full 2>&1
>  
>  echo "*** populate filesystem, pass #2" | tee -a $seqres.full
> -cp -rf $filler $SCRATCH_MNT/subdir >$seqres.full 2>&1
> +cp -rf $filler $SCRATCH_MNT/subdir >>$seqres.full 2>&1
>  
>  _check_scratch_fs
>  
> 

