Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0294B1E8345
	for <fstests@vger.kernel.org>; Thu,  1 May 2025 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746090106; cv=none; b=FCdixe6UBhUITV7QTiIQgjOobPv/CqaRLlCvwOouBNgnx7qSMo1g5i9XmQCPDDNiWpWkjxaHzJCfCCkBLFOD8ilHl0IxSqKI9Xp0tkgLOcDTx32e517x7tFyccdwcCxCs8Naiuo0Zua9svi/JzuW+t0EAFMJaunnX0k8xImZPCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746090106; c=relaxed/simple;
	bh=PPi9zhVV6WaRhBdqGzMVp/xfcXv3iaBbS92wdDKS/0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ru0B+VMkdVidcL9LG36kksgrsLlrvRnwXH+9mZbakSX3+GG8oVmMXxW436Jt9TF6WolebaA7NDkIUpjzNQpRKUfb+2YlEuoX5iVEIU8dLO5n7unJu532GmPpS1faHPo8J5EBXHq5zTrFMC5RXjPBbXYLW9V2KCkvZ6C+tgY8ZAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GIVwaRkz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GIVwaRkz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746090102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cfJAhOmcTzEsI3SP+Gu+yZTbB3Sk1+KpXR6qToQojIA=;
	b=GIVwaRkzMAGIo7WBs6b2whrMxU/ApQpV3muCSir6gOgpm0p8jBs9Vn6LGGLiajPYSP9R7X
	+OlZbfiu81pt6EahpFTPELFEaEyaYbgCat6o4gkQBJVEjrjkFKS95xn8hfOHoz+hMJ6Hbr
	X/ytNCbno71VZHK5ruJD9MJuw2bWN6k=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-rWvo0WOlNJmcgW-gGaTBlQ-1; Thu, 01 May 2025 05:01:41 -0400
X-MC-Unique: rWvo0WOlNJmcgW-gGaTBlQ-1
X-Mimecast-MFC-AGG-ID: rWvo0WOlNJmcgW-gGaTBlQ_1746090100
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b1f8d149911so457786a12.0
        for <fstests@vger.kernel.org>; Thu, 01 May 2025 02:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746090100; x=1746694900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfJAhOmcTzEsI3SP+Gu+yZTbB3Sk1+KpXR6qToQojIA=;
        b=hdX0Tu0ue23Twji6JGrQ8zVSvt8AEBokocQm7w3DWG95stpImy0Z6+ysPhrp1eoMq8
         YO9NJH3Nd+Ou/x9uC1xFgT1WJxBMGkQEuCNDKyYT2fVxR/94gPbVuX4mmbyRQyvAite7
         325MMuFirVXbSH3j5MxOKQl/NIXN5yZ1u7KQ3PM5hWP0Mtw9fEewVnXPtr/rFZ6dY+fK
         LKWB7jJDZs6FkUw/4PxqSBwdtUbv71hTETLUK+/qdHtPLHmu8/9XHUSLOgeiXlkoj8sM
         CGQdqmy+S/llIciLL5jIWH4LcemmVo1Biris5vWGYGAlmsHS/NC/m8+74yNDC+83/5PS
         CtjA==
X-Gm-Message-State: AOJu0YxJLZa8VbjxriXw4r/zgaKNNrwUZPUgesH5nr/8tUS9OCRj+rV/
	DB8Nu04e56lj678HWuWDaJKXsfx1fooZeXt+zVoBRUYsB5MsZxHDJ8LWuaZ7PmWKy3f24TruZwL
	qFnZomFtuWfPAtQZFbC7ku9iHxvu7YWd4JH/Vw4BSYZCAZ7uwNwrj1x4=
X-Gm-Gg: ASbGncuWi4zHIuTA3MWToWmkI6wjLqdksYbVW7tZxaKEClZtKsXj4eCNsjNFXga/0ZD
	cuDGyHxTpryZFxXamrBnIImE4WURi6CB5vovkv6jn+W1POlxxAshazDDffDh+Fen0s+CmnrWYYp
	S7YF/hIWIQSVfH1t4YAnK4RYXGqCXh7VMrEMUcBcGzh0L2X4K3I6Hg6ThXd+/d5c+uoXB2TWzf2
	PSi4OXMMYpdzqxoGDSipqQaBoG9tWnHP24LvcM8EzA1yLaowLZDKOl7/+mr+8ppOpEvP7gxR7i7
	5SfK/qo6JBr9K1oOitLVJD3tJLT/uW4hIeeI0R7ovwdmZUrPdBOT
X-Received: by 2002:a05:6a20:394f:b0:1f5:8622:5ed5 with SMTP id adf61e73a8af0-20ba6a18194mr3514714637.3.1746090100443;
        Thu, 01 May 2025 02:01:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcSRf5ZOUhIXom/AjwkdaT8xQKO7X7w7CGCNIcz1pHVEBeJLSPjxE85KE6jInVd0EqTYUPzQ==
X-Received: by 2002:a05:6a20:394f:b0:1f5:8622:5ed5 with SMTP id adf61e73a8af0-20ba6a18194mr3514684637.3.1746090100091;
        Thu, 01 May 2025 02:01:40 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1f9d477860sm302298a12.12.2025.05.01.02.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 02:01:39 -0700 (PDT)
Date: Thu, 1 May 2025 17:01:36 +0800
From: Zorro Lang <zlang@redhat.com>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH] generic/126: Do not run if TEST_DIR is sticky and
 fs.protected_regular enabled
Message-ID: <20250501090136.r46dwhzg3eshupkl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <51ac35ec-1f3f-45d9-9cef-1ee424a9f9fe@sandeen.net>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51ac35ec-1f3f-45d9-9cef-1ee424a9f9fe@sandeen.net>

On Wed, Apr 30, 2025 at 05:10:36PM -0500, Eric Sandeen wrote:
> generic/126 fails in somewhat mysterious ways when run on tmpfs on
> systems that have the fs.protected_regular sysctl set > 0, because
> tmpfs defaults to having the sticky bit set, and this causes
> may_create_in_sticky to fail when the test tries to create writable
> files.
> 
> To fix this, _notrun the test if TEST_DIR is sticky, and the protection
> is enabled.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---

Hi Eric :)

> 
> diff --git a/tests/generic/126 b/tests/generic/126
> index 142d2bb9..007e4433 100755
> --- a/tests/generic/126
> +++ b/tests/generic/126
> @@ -21,6 +21,13 @@ _cleanup()
>  _require_test
>  _require_chown
>  
> +# If the TEST_DIR has the sticky bit (like tmpfs) and this has restrictions,
> +# skip this test, because fs.protected_regular changes expected behavior.
> +PROT=n=$(sysctl -n fs.protected_regular 2>/dev/null)
        ^^
     What's this for? Do you hope to have PROT="n=1"?

> +if [[ -k "$TEST_DIR" && "$PROT" -gt "0" ]]; then
> +	_notrun "test dir has sticky bit and fs.protected_regular enabled"
> +fi

And didn't below commit fix the issue you hit?

commit bd6e01c81e2160ce660ad993091f30e6f718079a
Author: Jeff Layton <jlayton@kernel.org>
Date:   Thu Feb 20 06:26:38 2025 -0500

    generic/126: run it inside its own subdirectory

Thanks,
Zorro

> +
>  QA_FS_PERMS=$here/src/fs_perms
>  
>  cd $TEST_DIR
> 

