Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DE780B
	for <fstests@vger.kernel.org>; Mon, 15 Jan 2024 02:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKjX+vS4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705287496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tSRbNU66iET4NsqkQKp1FOa0Dd9GVKSornvZ1CQ/txQ=;
	b=AKjX+vS4eMGK86iHL3JK7gLYZ4inobyrqmcEm5rRDpMWhw3pFp48AMixd+Jx2EjBoxzKBH
	Uktwzk7ZzplbbZ3pglsOb/qj0bvJ6S1O/ctnO3kQlmAvBf5CFEDG1NaBtxzocoNk8xhk79
	js+1v6D0Gu9J4gU7T4H4Bo4xb21FRWE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-x1ZoAqioMJ6i0Djf9Wy0SQ-1; Sun, 14 Jan 2024 21:58:14 -0500
X-MC-Unique: x1ZoAqioMJ6i0Djf9Wy0SQ-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6d9b6701404so7271449b3a.2
        for <fstests@vger.kernel.org>; Sun, 14 Jan 2024 18:58:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705287493; x=1705892293;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tSRbNU66iET4NsqkQKp1FOa0Dd9GVKSornvZ1CQ/txQ=;
        b=CpVvb7yj1Et8/VRZkhJnVP3YiBzN+A86NH8wotxnKNoHGAB6p9hO4bJuoXQgAUP8a2
         fsZaV7IVx+lzelOFHyMVWGmQG8hGKwD+wmxF8Aph2M+p5v2UxDm7ZEY0KMFartNT8GeE
         9gBMJqw+fuSPosDdaXSomyCz/dv6br6aCp2XkdPu5dyA+ZIoBISu6/YLD8/mMS6ksS4Q
         vP4kp7Xh7KVhDAQL3TMQk3UwHsG57Snf3/3GRMJkfbrk/Jl8D/kgmfNybND7Ps8yAywU
         mRJUEeRY+AwihhcstHqsAruJAVuus+8UaGpwKEFW7LCCAY5er3CcI2lYVHrgORsTk8to
         x24w==
X-Gm-Message-State: AOJu0YwlR24rqqWm3hqRWKZSwVq29RzpCXk80X9liwYLRHJIDFVsgALh
	dLHiL9QwXQshf5x+ZEPKJVTERnH9Pni1DCqeXe5CIIy8839GsY3+cxYUlKjGfZCwLvStXMGbzmM
	OdfVZcKaLgyVu/uR3hppAmTz1zDvmdireaZzs
X-Received: by 2002:a05:6a00:398b:b0:6db:79f6:777b with SMTP id fi11-20020a056a00398b00b006db79f6777bmr1925877pfb.33.1705287493455;
        Sun, 14 Jan 2024 18:58:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/GDNsijp+B+YEwN9RW0g/BKkNwsXNQ83jvv9jz76IHoDHsSaJwXLB3kSNZl5thxiOk/gCAQ==
X-Received: by 2002:a05:6a00:398b:b0:6db:79f6:777b with SMTP id fi11-20020a056a00398b00b006db79f6777bmr1925872pfb.33.1705287493043;
        Sun, 14 Jan 2024 18:58:13 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x21-20020a056a000bd500b006da73b90fe4sm6837976pfu.14.2024.01.14.18.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 18:58:12 -0800 (PST)
Date: Mon, 15 Jan 2024 10:58:09 +0800
From: Zorro Lang <zlang@redhat.com>
To: Richard Weinberger <richard@nod.at>
Cc: fstests <fstests@vger.kernel.org>
Subject: Re: fsgqa group membership?
Message-ID: <20240115025809.5yypxbanvbnnzhrq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <1998649210.233983.1705246961955.JavaMail.zimbra@nod.at>
 <20240114201831.jhaww3xzbfqervc5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <1829752362.234840.1705265333986.JavaMail.zimbra@nod.at>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1829752362.234840.1705265333986.JavaMail.zimbra@nod.at>

On Sun, Jan 14, 2024 at 09:48:53PM +0100, Richard Weinberger wrote:
> Zorro,
> 
> ----- Ursprüngliche Mail -----
> >> It turned out that the test failed because the user "fsgqa" did not have the
> >> "fsgqa" group assigned.
> >> After rectifying this, the test passed successfully.
> > 
> > OK, so you've found out why it's failed :)
> 
> Yeah, but took me more time than it should. ;-)
>  
> >> 
> >> But it is nowhere stated that this has to be that way.
> >> 
> >> README says only:
> >> 6. (optional) Create fsgqa test users and groups:
> >> 
> >>    $ sudo useradd -m fsgqa
> >>    $ sudo useradd 123456-fsgqa
> >>    $ sudo useradd fsgqa2
> >>    $ sudo groupadd fsgqa
> >> 
> >> Just in case, users fsgqa and fsgqa2 want the groups fsgqa/fsgqa2 as their
> >> primary groups
> >> to have all tests work as expected?
> > 
> > Actually above steps aren't exact enough. It depends on a default behavior
> > of useradd command -- "By default, a group will also be created for the
> > new user" (from `man useradd`)
> > 
> > And according to the manual:
> > 
> >       -g, --gid GROUP
> >           The name or the number of the user's primary group. The group name must exist. A
> >           group number must refer to an already existing group.
> > 
> >           If not specified, the behavior of useradd will depend on the USERGROUPS_ENAB
> >           variable in /etc/login.defs. If this variable is set to yes (or -U/--user-group
> >           is specified on
> >           the command line), a group will be created for the user, with the same name as
> >           her loginname. If the variable is set to no (or -N/--no-user-group is specified
> >           on the command
> >           line), useradd will set the primary group of the new user to the value specified
> >           by the GROUP variable in /etc/default/useradd, or 1000 by default.
> > 
> > You said "After migrating to a new test environment", I don't know what's
> > your new test env. Maybe your USERGROUPS_ENAB isn't set to yes by default,
> > or your useradd has an alias "useradd -N", or any other reasons.
> 
> SUSE Linux has traditionally not set USERGROUPS_ENAB, this explains the issue.
> The old setup was not SUSE based.

Thanks for this information!

> 
> > Anyway if you hope to make sure each fsgqa users is assigned to their
> > own group, how about:
> > 
> > $ groupadd fsgqa
> > $ useradd -m -g fsgqa fsgqa
> > $ groupadd fsgqa2
> > $ useradd -g fsgqa2 fsgqa2
> > $ groupadd 123456-fsgqa
> > $ useradd -g 123456-fsgqa 123456-fsgqa
> 
> Sounds good! It is verbose but that way everybody will know and it will work
> on "strange" systems too.

I'll send a patch to change that. Or you can do that too if you'd like, and feel
free to tell us if you find more fstests' issues.

Thanks,
Zorro

> 
> Thanks,
> //richard
> 

