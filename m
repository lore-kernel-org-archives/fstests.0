Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214904C99
	for <fstests@vger.kernel.org>; Sun,  3 Mar 2024 05:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709442545; cv=none; b=LuqTuX8vV7oGHtZV6VAi0DdN3ZpZHAEHgF3Pa+GBlSEjB0i897aC8Eyd48bpc3k7uGrklOK3MUvQyIHAqcX0zSPiwsnlwn2KgwGNuUcrcgWADaC1bQB2Y3+4sWb/ALqHmUxzT1rFBFwFLYLPiz+mMMwr0s7Cdof1DiNU39N93hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709442545; c=relaxed/simple;
	bh=l8gGo5ufDURZHmdvzVjci3F2EHTlOcDdHG1mCj3W+XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqCISI8ouCh+H9O+3yppiNjX0xJAtUmEcpQu7cQPEKQz2XXzMQefgpAId0VJAU6uwGCpu6aiMP5MQM+GHnZQP6kSdAnQvvd4HqBp8bYn+xX5llaXbF0oHp/ukAE852qyQLsw+YyxiskcLIzVjdA5F9Kq6m+TdLyHbzEcdnsMqFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GX3y8m9c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GX3y8m9c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709442541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JjpbPJcNRbSanMTpfhHKtMnGxhnRcTaRo2vwe3NOWtk=;
	b=GX3y8m9c7DArfzRfTudoDwSWiDgOU0WQLxoVFHTXvexXz0YomhHqIDwZKfDheyRL40IgrL
	TJIDxjTWWG3J7B2dGatsm/cJ7miIwEtSq5BmK9HSWtXHBUblmPlfIRsQgUuDRcN9wGMA+U
	dEuKMxCjK3ZLKZj4V+x/nw1+FudVXXk=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-pqJrsiJTMRK6nC4e0H34uw-1; Sun, 03 Mar 2024 00:08:59 -0500
X-MC-Unique: pqJrsiJTMRK6nC4e0H34uw-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3c1b8b34512so3272149b6e.2
        for <fstests@vger.kernel.org>; Sat, 02 Mar 2024 21:08:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709442539; x=1710047339;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JjpbPJcNRbSanMTpfhHKtMnGxhnRcTaRo2vwe3NOWtk=;
        b=bILKIozshh90QO8UWQ9a5MYF4BZntd1VdjMJ/AO1uXiDuqs7NZ0m1W+c/YByBx1mWs
         dfafDF9YU7pMtcLwN7nMSGKGcDSbwPpgaHqYjhBecfVzH7ylw+QAoWxdoMVmXrPonRNf
         a86ePuvu7NnM419zS+dkAcfXP1kzY8MPItiPYwEvlHf+dfngFZc+5r3jMj4lgDwkWB+Z
         DBDsB1viKFyXJ92zepZhxm2euUwfHG4WHLkjdLHWBCQPcAQZJdUKpfaYJv0q17+XPa50
         lnfkPXPDkW0oXhBUzxqHWKd5OSlXzRprMXuSKzk+c98BTDDanZ6KeWypGbXTcWW/fC6D
         uSuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG24zD6eRBKApIfZwkXQOyi6GBcGU8MwNxkdR3loMWl7+mJlBvZUBPXpDku0ziRDQyNhu9AesC4qVjE+/4msKeGqQnMfo+VA==
X-Gm-Message-State: AOJu0YzERIjewAOGz01DtsHBuy2mfKzRnkiGYCSXVrrf7pGNEK8EiFoY
	UjxKaPYeKAxOG+CHdRkNLMEiGJEhojAW+lwvds1yrEOorayZQmOVCRHpBHUgoXu1wu1hswah8rH
	Gfc3S/joqN17IH7Wu1g6pevVW0Yazup03FpSStptjkGKcW5rRV5zpqtg=
X-Received: by 2002:a54:4388:0:b0:3c1:e835:3f8a with SMTP id u8-20020a544388000000b003c1e8353f8amr2050890oiv.39.1709442538709;
        Sat, 02 Mar 2024 21:08:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjv5iSXFkzoq34jTrZUzYGVoxQrDPBhk2ZX6DFNrWuKHpObbhXi7qJfeoIgV8G5L/hrfVcZA==
X-Received: by 2002:a54:4388:0:b0:3c1:e835:3f8a with SMTP id u8-20020a544388000000b003c1e8353f8amr2050878oiv.39.1709442538325;
        Sat, 02 Mar 2024 21:08:58 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090a458800b0029af67d4fd0sm5526321pjg.44.2024.03.02.21.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 21:08:57 -0800 (PST)
Date: Sun, 3 Mar 2024 13:08:53 +0800
From: Zorro Lang <zlang@redhat.com>
To: Paulo Alcantara <pc@manguebit.com>,
	Alexander Aring <aahringo@redhat.com>
Cc: Steve French <smfrench@gmail.com>, fstests@vger.kernel.org,
	gfs2@lists.linux.dev, jlayton@kernel.org,
	linux-cifs@vger.kernel.org
Subject: Re: [PATCHv2] generic: add fcntl corner cases tests
Message-ID: <20240303050853.f7wslqfkkgdfv37i@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20230925201827.1703857-1-aahringo@redhat.com>
 <20240209052631.wfbjveicfosubwns@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAH2r5msWwX7QdXrzmR3tapU85WMga9Y-waNOHm+hMWmWPUF=tQ@mail.gmail.com>
 <20240209114310.c4ny2dptikr24wx5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240301103835.gylf2lzud2azgvx7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAK-6q+jZVfK2=Z6RCCU+K+TLYuHgC4ynqOBz3K-nhcypCoN3ww@mail.gmail.com>
 <a5eb6c3a2de1b959117d49c436b81904@manguebit.com>
 <CAK-6q+isU4cQN6OV_bLmoKwULsisAUpkAZA+c6SRgOCk8Z9T=g@mail.gmail.com>
 <a6806fcca760e734f272596cafc2390f@manguebit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6806fcca760e734f272596cafc2390f@manguebit.com>

On Fri, Mar 01, 2024 at 08:59:01PM -0300, Paulo Alcantara wrote:
> Alexander Aring <aahringo@redhat.com> writes:
> 
> > Hi,
> >
> > On Fri, Mar 1, 2024 at 11:25 AM Paulo Alcantara <pc@manguebit.com> wrote:
> >>
> >> Hi Zorro,
> >>
> >> The problem is that cifs.ko is returning -EACCES from fcntl(2) called
> >> in do_test_equal_file_lock() but it is expecting -EAGAIN to be
> >> returned, so it hangs in wait4(2):
> >>
> >> ...
> >> [pid 14846] fcntl(3, F_SETLK, {l_type=F_WRLCK, l_whence=SEEK_SET, l_start=0, l_len=1}) = -1 EACCES (Permission denied)
> >> [pid 14846] wait4(-1,
> >>
> >> The man page says:
> >>
> >>       F_SETLK (struct flock *)
> >>               Acquire a lock (when l_type is F_RDLCK or F_WRLCK) or release  a
> >>               lock  (when  l_type  is  F_UNLCK)  on the bytes specified by the
> >>               l_whence, l_start, and l_len fields of lock.  If  a  conflicting
> >>               lock  is  held by another process, this call returns -1 and sets
> >>               errno to EACCES or EAGAIN.  (The error  returned  in  this  case
> >>               differs across implementations, so POSIX requires a portable ap‐
> >>               plication to check for both errors.)
> >>
> >> so fcntl_lock_corner_tests should also handle -EACCES.
> >>
> >
> > yes, that is a bug in the test but in my opinion there is still an
> > issue. The mentioned fcntl(F_SETLK) above is just a sanity check to
> > print out if something is not correct and it will print out that
> > something is not correct and fails.
> 
> Yes, I agree it might be a cifs.ko issue.  However, it's still important
> making sure that the test exits gracefully and then report an error
> rather than hanging.

Thanks for all of you look into it!

If the C program can deal with issue (report error rather than hang),
that would be good. Or how about give the fcntl testing process a (long enough)
timeout number, to avoid it block the whole fstests test running, and report
error if it exits unnormally.

Thanks,
Zorro

> 
> > The problem is that wait() below, the child processes are not
> > returning and are in a blocking state which should not be the case.
> >
> > What the test is doing is the following:
> >
> > parent:
> >
> > 1. lock(A) # should be successful to acquire
> 
> Client successfully acquires it.
> 
> > child:
> > thread0:
> > 2. lock(A) # should block
> > thread1:
> > 3. lock(A) # should block
> 
> OK - both threads are blocked.
> 
> > parent:
> >
> > 5. sleep(3) #wait until child are in blocking state of lock(A)
> 
> OK.
> 
> > 5. unlock(A) # both threads of the child should unlock and exit
> 
> At this point, both threads are woken up and one of them acquires the
> lock and returns.  The other thread gets blocked again because it finds
> a conflicting lock that was taken from the other thread.  The child then
> never exits because it is waiting in pthread_join().
> 
> > 6. sleep 3 # wait for pending unlock op (not really sure if it's necessary)
> > ...
> > 7. trylock(A) # mentioned sanity check
> 
> Client returns -EACCES because one of the child threads acquired the
> lock.
> 
> > The unlock(A) should unblock the child threads, it is important to
> > mention that this test does a lock corner test and the lock(A) in both
> > threads ends in a ->lock() call with a "struct file_lock" that has
> > mostly the same fields. We had issues with that in gfs2 and a lookup
> > function to find the right request with an async complete handler of
> > the lock operation.
> 
> Alex, thanks for the explanation!  As we've talked, there might be a
> missing check of fl_owner or some sort of protocol limitation while
> checking for lock conflicts.
> 
> Steve, any thoughts on this?
> 

