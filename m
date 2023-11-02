Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5B033E1
	for <fstests@vger.kernel.org>; Thu,  2 Nov 2023 08:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5+9QNYJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E69102
	for <fstests@vger.kernel.org>; Thu,  2 Nov 2023 01:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698912406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YO51pErDWlQ8VqujOtiWVAcZ89fhijZ07CdGuFlXfm0=;
	b=A5+9QNYJAOXRlWWqbuGH6K/QGI7ZHCUS62ZBMdLGjlDC8bB4mBe5eQraLOvTUti2e//G8T
	Yze5TRwG/4zLjrBgGDaCLsCTcD9z6MVQcGDZ/Acxc/FszYaHJf6WhmMkhMwe5djgXVxoFo
	eV6NBplGU7eglS25M+4LAsFKi0yW2DU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-znO7cookPfWmuptiZV8eDg-1; Thu, 02 Nov 2023 04:06:45 -0400
X-MC-Unique: znO7cookPfWmuptiZV8eDg-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5b8a63ccb53so1343065a12.0
        for <fstests@vger.kernel.org>; Thu, 02 Nov 2023 01:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698912404; x=1699517204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YO51pErDWlQ8VqujOtiWVAcZ89fhijZ07CdGuFlXfm0=;
        b=PNfDYLsbJsZeyfqslvmi3jwNVlCp/j8wA3Fi8PFUVgCkumiCQKsN+cZGyqw7XXg+Un
         h7ihM/h2R25iC9HhBJYIGnwv0qeVUBwhdbiv14xUvA+7vvFmaUT9y2Qil9/FBJv54JOT
         En0UOm3J1cIVOuUmO0L+l9jrknzM/yyy5rkN+LSuOtQvw2hVLGqXoAkac1pUrWO3N2GE
         TOqEXplCpy19TmBjbqbEwiEnPcaru+za65e1Adisc3wBCD6cmg42iq/3Gz9zhcdl2+qr
         HS1+ZqeWG9GwK+O4l6FcVjb5SX4Rgf+nVMQ7jWUT1KTMdFmK8tHutxJJFxUQrBrwuzM2
         +Jng==
X-Gm-Message-State: AOJu0YwV1iluSmuTRD+kNKnH6TLsSCcBYxFRRr8XsFcyd17khp8kRtmc
	EezHmtiMANlUxegAblZfPy+dr7gloPvwTei+TIYOLJ9Yj0Vp9BIpJt3bSStluVh72A3df/WhDGB
	Icvdo4W/KVAFDpu456A==
X-Received: by 2002:a17:90b:38c5:b0:27d:2ce9:d6d5 with SMTP id nn5-20020a17090b38c500b0027d2ce9d6d5mr11465595pjb.12.1698912404104;
        Thu, 02 Nov 2023 01:06:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZCfR1FaH2QBa93DBXDzl85ImA3WUK02REuo6cZHOyUltlfjsPiHIwkkWX5oualM8Ft1QuAg==
X-Received: by 2002:a17:90b:38c5:b0:27d:2ce9:d6d5 with SMTP id nn5-20020a17090b38c500b0027d2ce9d6d5mr11465581pjb.12.1698912403801;
        Thu, 02 Nov 2023 01:06:43 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id k5-20020a17090ad08500b002802d9d4e96sm1918892pju.54.2023.11.02.01.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 01:06:43 -0700 (PDT)
Date: Thu, 2 Nov 2023 16:06:40 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org, Yongcheng Yang <yoyang@redhat.com>
Subject: Re: [PATCH] generic/732: fix mount option munging
Message-ID: <20231102080640.bntmfreb7t5rh4wp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231101-master-v1-1-08bbe2f83307@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101-master-v1-1-08bbe2f83307@kernel.org>

On Wed, Nov 01, 2023 at 02:17:13PM -0400, Jeff Layton wrote:
> With NFS in particular, we are usually testing with some mount options.
> Ensure that we preserve those and just add "nosharecache" onto the end
> of the string.
> 
> Cc: Yongcheng Yang <yoyang@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  tests/generic/732 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/732 b/tests/generic/732
> index 785aac58f361..ae49152e42dc 100755
> --- a/tests/generic/732
> +++ b/tests/generic/732
> @@ -40,7 +40,7 @@ mkdir -p $testdir1 $testdir2
>  # Don't share the data and attribute caches among mount points for NFS.
>  # This caching behavior is necessary to reproduce this issue as we're
>  # checking the alignment of each mount point's own unique cache.
> -[ "$FSTYP" = "nfs" ] && MOUNT_OPTIONS="-o nosharecache"
> +[ "$FSTYP" = "nfs" ] && MOUNT_OPTIONS="$MOUNT_OPTIONS -o nosharecache"

Good to me, and looks like the later option replaces the former one, if
there're same options (e.g. -o sharecache -o nosharecache).

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  
>  SCRATCH_MNT=$testdir1 _scratch_mount
>  SCRATCH_MNT=$testdir2 _scratch_mount
> 
> ---
> base-commit: 59299b65ac8f15935ab45e7920cbfda8a6beffd1
> change-id: 20231101-master-328ff30ce66f
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
> 

