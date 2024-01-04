Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5036E1DDC3
	for <fstests@vger.kernel.org>; Thu,  4 Jan 2024 08:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JcP7aGqW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704357676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vc8NBSAawIwdgl1VM5KwTgnXHk82alBsww3gmwShkuY=;
	b=JcP7aGqWdqt1bJjX/SNmxy+lZ9kyPg4oQyn6e825vTxSS14N4eruTkWn93Pm9UVEzOOQIK
	5WtGhMkI3LIQYFbNBSHRQoun4wNBWu7Erl7Y1cfS6oUg/9PxATzCqh91jIcauDLQXrBYcv
	pNwg9zXnRUkRX+KQ3QhvRhNXagVhow8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685--AB5Ri81NwuQbBHXUfLiXw-1; Thu, 04 Jan 2024 03:41:15 -0500
X-MC-Unique: -AB5Ri81NwuQbBHXUfLiXw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c670f70a37so252824a12.2
        for <fstests@vger.kernel.org>; Thu, 04 Jan 2024 00:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704357674; x=1704962474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vc8NBSAawIwdgl1VM5KwTgnXHk82alBsww3gmwShkuY=;
        b=i88MFLAs99wrgIA2Zdq/NLes3W4XwOjtpHy890VOQtdf1ljO7BBgHCBLwPgOOc35zW
         Bj7hHHYMczB6PkdFsaQNU96VhAhidGx36IgLVjsY/z5ewbh1Pl8Ld7Wf1dPTP54ss1QQ
         0HFAcypCT8O9Wx4emCxr3yZzkpzWNWfIKD6O4U+3lGHMe6aTIpPI5fY+gCTn9akmvvco
         oQATrjUyU0zIhKGfGD1Mr+X/6xOROa61MNEiVpPFaHBUjpGGIWMETHVqJYuPhjfMugsp
         hOgpTz2uu0IYNyIO8nKeE2UKkP6e59e3QIdpd0STUaGJBNrabcZrhRmuac6n6CZACuwz
         NaDA==
X-Gm-Message-State: AOJu0YzZAoZzNC+JWmqI0qpGlKoQ/BIsQl6+Ps6RO6HjtOvu31xnUpAB
	KqiXZlx5YZdrD1qmUlOqWCQa44VGpzu+Pwi4/1QPpv01RAgE746E3TQ5ycbJUCYctoTHVMpGZ5x
	bN24R+rYCEzZGq8BU9deMIvXCIhf8rpXOf6DricU=
X-Received: by 2002:a17:902:ec87:b0:1d3:f285:ab4 with SMTP id x7-20020a170902ec8700b001d3f2850ab4mr223345plg.121.1704357674045;
        Thu, 04 Jan 2024 00:41:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG66GfVRzoto5aNS0G82DdxEfHVVxH8PZ9jfI3qPz68Y5C7prZEEox9Nab3r0Qf7Owdp4VTRw==
X-Received: by 2002:a17:902:ec87:b0:1d3:f285:ab4 with SMTP id x7-20020a170902ec8700b001d3f2850ab4mr223340plg.121.1704357673745;
        Thu, 04 Jan 2024 00:41:13 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902b78c00b001cfca7b8ee7sm24986239pls.99.2024.01.04.00.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 00:41:13 -0800 (PST)
Date: Thu, 4 Jan 2024 16:41:08 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chung-Chiang Cheng <cccheng@synology.com>
Cc: fstests@vger.kernel.org, shepjeng@gmail.com, kernel@cccheng.net
Subject: Re: [PATCH] README: add a missing necessary package
Message-ID: <20240104084108.m3ts24cee7nb7wom@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240104054236.1311678-1-cccheng@synology.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104054236.1311678-1-cccheng@synology.com>

On Thu, Jan 04, 2024 at 01:42:36PM +0800, Chung-Chiang Cheng wrote:
> src/dbtests.c requires 'gdbm-ndbm.h' or 'ndbm.h', both of which are
> supplied by 'libgdbm-compat-dev' in the latest Ubuntu LTS. However,
> this package is not a dependency of the currently listed packages.
> Therefore, add it explicitly to the necessary packages list.
> 
> $ dpkg -L libgdbm-compat-dev
> /.
> /usr
> /usr/include
> /usr/include/dbm.h
> /usr/include/gdbm-ndbm.h
> /usr/include/ndbm.h
> 
> Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
> ---
>  README | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/README b/README
> index e0dabe96503a..c46690c4eabb 100644
> --- a/README
> +++ b/README
> @@ -11,7 +11,8 @@ Ubuntu or Debian
>     $ sudo apt-get install acl attr automake bc dbench dump e2fsprogs fio gawk \
>          gcc git indent libacl1-dev libaio-dev libcap-dev libgdbm-dev libtool \
>          libtool-bin liburing-dev libuuid1 lvm2 make psmisc python3 quota sed \
> -        uuid-dev uuid-runtime xfsprogs linux-headers-$(uname -r) sqlite3
> +        uuid-dev uuid-runtime xfsprogs linux-headers-$(uname -r) sqlite3 \
> +        libgdbm-compat-dev

Oh, We call it "gdbm-devel" in Fedora. Thanks for this updating for Debian!

Reviewed-by: Zorro Lang <zlang@redhat.com>


>  
>  2. Install packages for the filesystem(s) being tested:
>  
> -- 
> 2.34.1
> 
> 

