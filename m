Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782111C290
	for <fstests@vger.kernel.org>; Tue, 16 Jan 2024 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cE+BcMdO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705422411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQzXUGVo1BU0iuqI7xCmHjIjM8+V/hF0bQHOTaXhutk=;
	b=cE+BcMdOaaNpPOw8SqwPWUGkVcG/ykdIg7h4AKAe1LjWIe/HdZM5I44SwQRNxxYw/Ex9LX
	JhtrNF3Esis8pgHBIv+ImcmbwdxNvFHPHVKUAOGC7z/wAX7Ab9XCHHkRGQDuWdaoTJGH3D
	WnAiWnkKoWk2ab69t/kD7Qq6awVOY3s=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-QAXhynHdNbawIW-cz7b7_w-1; Tue, 16 Jan 2024 11:26:48 -0500
X-MC-Unique: QAXhynHdNbawIW-cz7b7_w-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6d9b266183eso6083308b3a.1
        for <fstests@vger.kernel.org>; Tue, 16 Jan 2024 08:26:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705422407; x=1706027207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQzXUGVo1BU0iuqI7xCmHjIjM8+V/hF0bQHOTaXhutk=;
        b=BtMUo0ejp12PMiXcG/oRp47PhGQt+ltZrqC9C9h2+xHxLL3+FaxWrZzmWbGkrC5ckJ
         j2C+10jcVe6fd6mj2nHaqdrSXibFipTnn0NJMk/d5+Xjs6E2qYpBQ4vyvJ8MqpUsN1qd
         g3QV2VfrV24f/e5pdGUzrNPsgAxkFiujQV1bqEdjavW24hXqvSyKnFM/WX4pdja03urR
         YjucQHxY866jOWESf8HkJcjGPTWQ516faA8u/unHtEkrBFOMlZ/8r7V4iADtazqoZZhR
         3Aq68L7+z3KNJib30DuMdQbJn3K1xs1/yq2TIesvpn5lYWJqI/ilZlS3mncIIVuSlRHv
         2yLw==
X-Gm-Message-State: AOJu0Yxsdd8vOZg/oWXwdDt4PJ8HLOeR5l0+9gdw7ma7EuuGrN+mKppK
	aoE8cOZ6la080USDvY/UNVsQNmyFyEMBXJxMc9scbGZtOPnvZD/p6xVmxbwL/FsGuSFpQAcgVso
	JQZ10gcea5dbEdtBHKZJhkPa7lg==
X-Received: by 2002:a05:6a20:4394:b0:19a:e767:eddb with SMTP id i20-20020a056a20439400b0019ae767eddbmr2572759pzl.114.1705422407444;
        Tue, 16 Jan 2024 08:26:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/7+Cb5aEHyqnDj8Wxx6WHRb8ffHnycupTZwcvOO89/HobgKfconwegdWfIvSLzQa8CGhKaA==
X-Received: by 2002:a05:6a20:4394:b0:19a:e767:eddb with SMTP id i20-20020a056a20439400b0019ae767eddbmr2572748pzl.114.1705422407114;
        Tue, 16 Jan 2024 08:26:47 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j21-20020aa78015000000b006d9c972ec57sm9757941pfi.174.2024.01.16.08.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 08:26:46 -0800 (PST)
Date: Wed, 17 Jan 2024 00:26:43 +0800
From: Zorro Lang <zlang@redhat.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Richard Weinberger <richard@nod.at>, fstests@vger.kernel.org
Subject: Re: fsgqa group membership?
Message-ID: <20240116162643.3esm7icq7igajcoa@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <1998649210.233983.1705246961955.JavaMail.zimbra@nod.at>
 <20240115025706.GF911245@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115025706.GF911245@mit.edu>

On Sun, Jan 14, 2024 at 09:57:06PM -0500, Theodore Ts'o wrote:
> On Sun, Jan 14, 2024 at 04:42:41PM +0100, Richard Weinberger wrote:
> > It turned out that the test failed because the user "fsgqa" did not
> > have the "fsgqa" group assigned.  After rectifying this, the test
> > passed successfully.
> > 
> > But it is nowhere stated that this has to be that way.
> > 
> > README says only:
> > 6. (optional) Create fsgqa test users and groups:
> > 
> >    $ sudo useradd -m fsgqa
> >    $ sudo useradd 123456-fsgqa
> >    $ sudo useradd fsgqa2
> >    $ sudo groupadd fsgqa
> 
> The useradd program creates the /etc/passwd entry as well as the
> /etc/group entry.  Demonstration:
> 
> % kvm-xfstests shell
>     ...
> root@kvm-xfstests:~# grep foobarbaz /etc/passwd
> root@kvm-xfstests:~# grep foobarbaz /etc/group
> root@kvm-xfstests:~# useradd foobarbaz
> root@kvm-xfstests:~# grep foobarbaz /etc/passwd
> foobarbaz:x:31418:31418::/home/foobarbaz:/bin/sh
> root@kvm-xfstests:~# grep foobarbaz /etc/group
> foobarbaz:x:31418:
> 
> I don't know why that "sudo groupadd fsgqa" is in the README; it's not
> necessary, and it would cause a "group already exists" error message.
> For example:
> 
> root@kvm-xfstests:~# groupadd foobarbaz
> groupadd: group 'foobarbaz' already exists

Hi Ted,

Yes, it'll fail as this, if USERGROUPS_ENAB is "yes" in /etc/login.defs.
That steps aren't correct 100%. I'll update this part description :)

Thanks,
Zorro

> 
> I did this demonstration using on a Debian-based test appliance.  But
> it looks like Fedora's "useradd" works exactly the same way.  See the
> web page here:
> 
> https://docs.fedoraproject.org/en-US/fedora/latest/system-administrators-guide/basic-system-configuration/Managing_Users_and_Groups/
> 
> 						- Ted
> 

