Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDDA101D2
	for <fstests@vger.kernel.org>; Sun, 14 Jan 2024 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iy6aUYWz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705263523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3tM6OXddE5YnSfAb7ZDvhjl4pDH7/itZTF1ZlN3W+N4=;
	b=Iy6aUYWz9J855fdoyzX7gWY72tun/YzOZjBDHN/rMGSnZQKL2fNc9RiKqGP7Jhgk5sPOMx
	S8In/WQKyLug8ebGLZxmd2AcRKtXQ7oYvFYqp0ybkoWqUjbr0LxtPhvl5USXw26RPnGQSz
	KmGukT5DHAgnLY3kmhkdKzDh2ocK/uo=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-pbyI4JA8MfOoC4Aq1d3XdQ-1; Sun, 14 Jan 2024 15:18:36 -0500
X-MC-Unique: pbyI4JA8MfOoC4Aq1d3XdQ-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-20418404dc6so8629858fac.2
        for <fstests@vger.kernel.org>; Sun, 14 Jan 2024 12:18:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705263516; x=1705868316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tM6OXddE5YnSfAb7ZDvhjl4pDH7/itZTF1ZlN3W+N4=;
        b=RJGPVtdkdsPEAKifEZPZ6p9F5zX/rF5MvOUsU2LEhZ+4ADX/INjfS17yA88vkii99+
         2xMx206dor/H61XHmGd/3+r+L60wSIozOw9v1JItg6pRKKKySJhtmC7zGlETPmvEA4FD
         HGuf/HDAHV/7X4Oyb8xF7rNTR9tBqfUim/0cn3DDvGeOx7VmwndbCJIh9d3tMxTryF2g
         7bButnpRIupObA9Zx4+AjR/YRCYNb/+Yr72zDhn3LuR0118UYHP5AkIpkh5gQSp6+WJ0
         AwqYwOd14+iimO25iIQaa3k17RBAJG8P3+6G3PBcxtJezoEY42mbAs7CA8X9TGqaUNe1
         mxpw==
X-Gm-Message-State: AOJu0YwkNhXupE9M2CwTW0WJgRwvg8201+3d9nDNXiCCNOVZSbyQUGZ9
	yWssXxmTgSw0QTNfha+2YjLkOjG7CFgrunaVf+CyjJNXxpuEFB0J3qMZ4GA8lgp6teoSAww/p3y
	/bVDsIxHOFzrUs99CJd/MKL4+AN0yniy1vA==
X-Received: by 2002:a05:6870:d8cb:b0:204:3026:3a4a with SMTP id of11-20020a056870d8cb00b0020430263a4amr6660501oac.17.1705263515813;
        Sun, 14 Jan 2024 12:18:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+He5YzSHTF3GKL9I3v7BKgYrg2/4u/yaqtHNFwd2HkqQRGg37hMacb2IELLkWHirzQNp3sg==
X-Received: by 2002:a05:6870:d8cb:b0:204:3026:3a4a with SMTP id of11-20020a056870d8cb00b0020430263a4amr6660492oac.17.1705263515454;
        Sun, 14 Jan 2024 12:18:35 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id su7-20020a17090b534700b0028da44b2c33sm10387497pjb.27.2024.01.14.12.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 12:18:35 -0800 (PST)
Date: Mon, 15 Jan 2024 04:18:31 +0800
From: Zorro Lang <zlang@redhat.com>
To: Richard Weinberger <richard@nod.at>
Cc: fstests@vger.kernel.org
Subject: Re: fsgqa group membership?
Message-ID: <20240114201831.jhaww3xzbfqervc5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <1998649210.233983.1705246961955.JavaMail.zimbra@nod.at>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1998649210.233983.1705246961955.JavaMail.zimbra@nod.at>

On Sun, Jan 14, 2024 at 04:42:41PM +0100, Richard Weinberger wrote:
> Hi!
> 
> After migrating to a new test environment, I observed that generic/193 failed.
> Initially, I assumed it was a UBIFS regression, but it appears that all other file systems have also been affected.
> 
> generic/193       - output mismatch (see /root/xfstests-dev/results//generic/193.out.bad)
>     --- tests/generic/193.out   2024-01-14 08:55:20.114082471 +0000
>     +++ /root/xfstests-dev/results//generic/193.out.bad 2024-01-14 14:30:51.598725128 +0000
>     @@ -45,10 +45,10 @@
>      check that suid/sgid bits are cleared after successful truncate...
>      with no exec perm
>      before: -rwSr-Sr--
>     -after:  -rw-r-Sr--
>     +after:  -rw-r--r--

Hi Richard,

Thanks for reporting this issue. Not sure why you get this failure by checking
this output only.

>      with user exec perm
>      before: -rwsr-Sr--
>     ...
>     (Run 'diff -u /root/xfstests-dev/tests/generic/193.out /root/xfstests-dev/results//generic/193.out.bad'  to see the entire diff)
> 
> It turned out that the test failed because the user "fsgqa" did not have the "fsgqa" group assigned.
> After rectifying this, the test passed successfully.

OK, so you've found out why it's failed :)

> 
> But it is nowhere stated that this has to be that way.
> 
> README says only:
> 6. (optional) Create fsgqa test users and groups:
> 
>    $ sudo useradd -m fsgqa
>    $ sudo useradd 123456-fsgqa
>    $ sudo useradd fsgqa2
>    $ sudo groupadd fsgqa
> 
> Just in case, users fsgqa and fsgqa2 want the groups fsgqa/fsgqa2 as their primary groups
> to have all tests work as expected?

Actually above steps aren't exact enough. It depends on a default behavior
of useradd command -- "By default, a group will also be created for the
new user" (from `man useradd`)

And according to the manual:

       -g, --gid GROUP
           The name or the number of the user's primary group. The group name must exist. A group number must refer to an already existing group.

           If not specified, the behavior of useradd will depend on the USERGROUPS_ENAB variable in /etc/login.defs. If this variable is set to yes (or -U/--user-group is specified on
           the command line), a group will be created for the user, with the same name as her loginname. If the variable is set to no (or -N/--no-user-group is specified on the command
           line), useradd will set the primary group of the new user to the value specified by the GROUP variable in /etc/default/useradd, or 1000 by default.

You said "After migrating to a new test environment", I don't know what's
your new test env. Maybe your USERGROUPS_ENAB isn't set to yes by default,
or your useradd has an alias "useradd -N", or any other reasons.

Anyway if you hope to make sure each fsgqa users is assigned to their
own group, how about:

$ groupadd fsgqa
$ useradd -m -g fsgqa fsgqa
$ groupadd fsgqa2
$ useradd -g fsgqa2 fsgqa2
$ groupadd 123456-fsgqa
$ useradd -g 123456-fsgqa 123456-fsgqa

Or
$ useradd -U fsgqa
$ useradd -U fsgqa2
$ useradd -U 123456-fsgqa

Or other better ideas. Does that help? If so, we can think about changing
the doc description.

Thanks,
Zorro

> 
> Thanks,
> //richard
> 

