Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5077319CC29
	for <fstests@vger.kernel.org>; Fri, 23 May 2025 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748011841; cv=none; b=B+a1ZuUeswrOZXAMSVyPuIgk9gp/Jex1IUCpd7crAojYOI/sl2tIPi2UarZYBU0aUoZAXotyxJyE4TtbwPeGrDsQXkDEcEmp3l5Z8YIOKSNg4esIQqiR9CJP5ylflOqu9LzMUE/mYa+LT3oGRR0jDLyDW5JxB/R/quTIQBvV7N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748011841; c=relaxed/simple;
	bh=O7p2mltt/0vUWbWw0+RJmsk3rfweC70X80nPyKhs5Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzBw3RH3Ds6pmK0K2HhUIIS6TzqnWjsWrgf/k8KtKwn7SWoTsWiASPSawdG5ftad0lWAiRwh8OYjhOzTj+z+NAnWhBXKJj3ArpCz1cLRGpchAIB/qE+wuDWYgL/k5TmNp3BihJhZ2eqLBePGBWvBjvdSEsseWsc6DfOJkG5Ak6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oc//67ZX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oc//67ZX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748011838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mxi7Zq0dR0jS8AnM3AdP8cSMjc8tuFOCv+7IW3IQb5E=;
	b=Oc//67ZXFA3IlMMRhHq/WBjME0M7xq/OvjwpcvczPaDVi6qnHhdbLDto6+GiIig35uYeVK
	u7SVSBfR8grgQpOyxxC6x2yLnBY/aYJcm0gOF11fvMzZNLWdjLgsgcyeWrC0yb1a1BTajM
	w7dD++HPsVC4TOIIb5PsZIFDVq0TuLM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-YEABibTxPsaOCSkgxC0NGw-1; Fri, 23 May 2025 10:50:37 -0400
X-MC-Unique: YEABibTxPsaOCSkgxC0NGw-1
X-Mimecast-MFC-AGG-ID: YEABibTxPsaOCSkgxC0NGw_1748011836
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7375e2642b4so16993b3a.2
        for <fstests@vger.kernel.org>; Fri, 23 May 2025 07:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748011836; x=1748616636;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mxi7Zq0dR0jS8AnM3AdP8cSMjc8tuFOCv+7IW3IQb5E=;
        b=KBGQ6GmWFfwO+Y5RI5BjvsWR/3JNE5XWgTfDLyQEseZ/F9u7FlfsMlJIQ7a3QyUXt/
         TGw93HVbMfmbEHlHZ4z7p8MHiaiqTs7ZYNxhq0bgWV106mBaELwAvFZy4tORHJBRGJ0J
         XsAkgtnNWpZWLjT9f24CKXZ27DEl5fg71skVxhwhGRPcoUk06U2us85iL7vdYvLGeh3q
         Rfl/X/cs+ytmNznJ6IW+aB8fqDsoWaj9/HDzLcO510zov5wGlm0rSnpqDRSreZKzx0J0
         VkqbBraohopIZ4aJFA+/lEJEZlIuM3BnO2JuFmL/A5OVSmWDZvf4NNkPee+bzrTKp94p
         Ft1g==
X-Forwarded-Encrypted: i=1; AJvYcCV4VxcNJH85aefpnfFLx1QwnV0AWRJ6Kwx7rCrXwjQl0/Xh3nUA1pqVa/ZsM/XDCNAgRsWo/ons@vger.kernel.org
X-Gm-Message-State: AOJu0YwwEG6VkfrAK+bqw1SBEg5ntr3WSNCnXBSSlGJgWissrP/UgJF4
	0/ux6PyUE3sqtNfHFkgaxFZej5biU7p+DusJwCw4D+UJjMa5svgYtI8zEU3YecY3PSKQlQNGVvf
	i1TC83c5QZ30MSBp74fltP7P4V98eIC1iq2guVANUr749Q5qH272EkKZH0uA=
X-Gm-Gg: ASbGnctbwrv0xIfAxRBok9JcusK50bPWmP0bRRVTmUwl7A1JF4A2hS6Cbou5KKaZ/C6
	WGpaHqofBqc1eQ8rqoKZ2du4pS3dKPI8nGFaCorgCf4ssfBDUvjGR9e5vd+gAfS1quU9gCNaW2z
	ThXqawKkYzRdGP6am7N9J9FvfX3CYuA2BY5tlJes3uobSQLpMDPf/cwQVLZpaoa2/ifq8fGC/+i
	0YMLsfOGaigytn26MI5gVDMq8TooyTKNLJGfny9rMzkltRLdJ7I6ysbYkiHX2wbLaZPui0/nTGx
	2L2+HOiqBUT4xKiUNOk57Ny1ZMnhf5x9PKM0prVMYAtlVqBfP40w
X-Received: by 2002:a05:6a21:4ccc:b0:1f5:6d00:ba05 with SMTP id adf61e73a8af0-216219f8fc6mr45988114637.38.1748011835929;
        Fri, 23 May 2025 07:50:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1w9qBZW5Gt9zNstNZDFOvmyKJMg7krNycYhMxSQIsqev12VaMfSfVxMJTYhLzOXzz7oMvsQ==
X-Received: by 2002:a05:6a21:4ccc:b0:1f5:6d00:ba05 with SMTP id adf61e73a8af0-216219f8fc6mr45988080637.38.1748011835604;
        Fri, 23 May 2025 07:50:35 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf8cc71sm12831936a12.35.2025.05.23.07.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 07:50:34 -0700 (PDT)
Date: Fri, 23 May 2025 22:50:28 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Tests for AT_HANDLE_CONNECTABLE
Message-ID: <20250523145028.ydcei4rs5djf2qec@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250509170033.538130-1-amir73il@gmail.com>
 <CAOQ4uxht8zPuVn11Xfj4B-t8RF2VuSiK3xDJiXkX8zQs7BuxxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxht8zPuVn11Xfj4B-t8RF2VuSiK3xDJiXkX8zQs7BuxxA@mail.gmail.com>

On Fri, May 23, 2025 at 04:20:29PM +0200, Amir Goldstein wrote:
> Hi Zorro.
> 
> Ping.

Sure Amir, don't worry, this patchset is already in my testing list.
I'll merge it after testing passed :)

> 
> On Fri, May 9, 2025 at 7:00 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > This is a test for new flag AT_HANDLE_CONNECTABLE from v6.13.
> > See man page update of this flag here [1].
> >
> > This v2 fixes the failures that you observed with tmpfs and nfs.
> >
> > Thanks,
> > Amir.
> >
> > [1] https://lore.kernel.org/linux-fsdevel/20250330163502.1415011-1-amir73il@gmail.com/
> >
> > Changes since v1:
> > - Remove unpredictable test case of open fh after move to new parent
> > - Add check that open fds are connected
> >
> > Amir Goldstein (2):
> >   open_by_handle: add support for testing connectable file handles
> >   open_by_handle: add a test for connectable file handles
> >
> >  common/rc             | 16 ++++++++--
> >  src/open_by_handle.c  | 53 ++++++++++++++++++++++++++------
> >  tests/generic/777     | 70 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/777.out |  5 ++++
> >  4 files changed, 132 insertions(+), 12 deletions(-)
> >  create mode 100755 tests/generic/777
> >  create mode 100644 tests/generic/777.out
> >
> > --
> > 2.34.1
> >
> 

