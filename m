Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5018313DB9C
	for <fstests@vger.kernel.org>; Wed,  6 Mar 2024 19:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755009; cv=none; b=HuXyI0nTmM5p1p1BNqNl9Gdre3Ugp+Z8gRu1O4UGQP9A0+1usLZO7tcmkOp87cY2NmnttsUWzUmqDg0qqRrtq0/7/Mi5RNT4DdjJk4/oLmu0poLqRkDro8s6Bp3Z/fr52HK08uqC2RKxW0VADLMYLInUE3HgDEa/SIIOVC9Grhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755009; c=relaxed/simple;
	bh=WwOZGOqufCnM+LmoEghJpWEI1xXGACezWh6JBXJEnow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9wnCt/Db8Bf4mkZGSj6X9YvOyyNHmxnsREfVkZXXZPH/1gVo5cGckwqX6KvwQ1tv177lXqGHNvNiViUcViJrYYPqxiKnGK0HJ8lfGqQgEyn7bB/mS7lYuwgmfN2UwJGOI6dX1FoKXZf1IPitVDBUK0StyQW9XtEppg+evwgwmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PBkOrV/i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBkOrV/i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709755006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qO3+X1vd5aHEnwQ+NjGahRyBGY8kyboJlNxdOazaIPA=;
	b=PBkOrV/iwqXs9XrzfMCLToWB7kZVnj5Idk3yeVCdgHs5qI1IurxtEA9mW/ocj4q3tyQpBy
	C+tnI8Bxq8Z/5GcV0/zmbt2hD9bXVIdxhPROyybk0/WpJz4pHi6hxEQXGrUKambj+ExtzC
	PNVI5reCBUIO+fGRdb8P9ZRubZEBKgM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-k23uokb7OQWO3oXzyJjF2w-1; Wed, 06 Mar 2024 14:56:44 -0500
X-MC-Unique: k23uokb7OQWO3oXzyJjF2w-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1dcabec8fddso867515ad.2
        for <fstests@vger.kernel.org>; Wed, 06 Mar 2024 11:56:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709755003; x=1710359803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qO3+X1vd5aHEnwQ+NjGahRyBGY8kyboJlNxdOazaIPA=;
        b=B52ikwF3qsyvLBrEGIr8KSI86Hn92YWw1CXA5lnSEb7BGhlK4nXTo42fQuTUsaO2t8
         0jTi7s+kGiJPZarp8xrZOkAZNzKHHBBjPRzzI/zwIUoyWWSCdY9BJFaHmFWXC5T9QTMH
         PdL674BvDtCw1r/FS+MaQ7U3pdzKeX5t1mJu9vqbXnEvCkJOatNI2bk2p6xDCf1z/Aeu
         r99OEZvY6AYhBd/y5wDbPP/dqZp5uyDkr1Fd+T9EUPrTgfDJvWzeMHVniexNEkk8V0rS
         RE0I1dzSwIAD5pviSwoCGIafAw2aBLnHpyhx48pfjSlYiKgZSr5fkZV/gjsRAMl6Vi42
         Vhgw==
X-Forwarded-Encrypted: i=1; AJvYcCU/z/n1DfszQOpc967N7WAUWQPiPjv+zSkCcIa2nl8fa7u0DOGjm+98eQCcLTQJk4R0IL05GEkt6jkC2p39d9Telfm6K0+rSQ==
X-Gm-Message-State: AOJu0Yx2rW8PUvY/wfGuN/jqs3JsVygK/yH3lX3RqvKNoMYPA/pJ0hwz
	5G2IZD/+yd8e1hZG71lyklEaCD/tVgQccDtKPrwRYJZP7gz3sToVU5fwi3cI94MuN6fzL9AfPXV
	3gFeH52ai0NscXJW1hysJ7P6n3uWvKDrJd/lbms0ixXlEArUZGQlfOFw=
X-Received: by 2002:a17:903:2444:b0:1dc:d52e:a038 with SMTP id l4-20020a170903244400b001dcd52ea038mr6928129pls.60.1709755002913;
        Wed, 06 Mar 2024 11:56:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3pdt14LeJcO+vMvbgZMi+SWe62XrZ0xOE7dTcMXpGNHHQdUwxALtEVQ1SEC6ra+fJ1ZF6dg==
X-Received: by 2002:a17:903:2444:b0:1dc:d52e:a038 with SMTP id l4-20020a170903244400b001dcd52ea038mr6928109pls.60.1709755002381;
        Wed, 06 Mar 2024 11:56:42 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id m18-20020a170902f21200b001da34166cd2sm13016388plc.180.2024.03.06.11.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 11:56:42 -0800 (PST)
Date: Thu, 7 Mar 2024 03:56:38 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [PATCH 3/3] common/rc: force enable io_uring in _require_io_uring
Message-ID: <20240306195638.tdw7upqc7om7x65b@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240306091935.4090399-1-zlang@kernel.org>
 <20240306091935.4090399-4-zlang@kernel.org>
 <20240306154324.GZ6188@frogsfrogsfrogs>
 <x495xxzuzaa.fsf@segfault.usersys.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x495xxzuzaa.fsf@segfault.usersys.redhat.com>

On Wed, Mar 06, 2024 at 10:59:25AM -0500, Jeff Moyer wrote:
> "Darrick J. Wong" <djwong@kernel.org> writes:
> 
> > On Wed, Mar 06, 2024 at 05:19:35PM +0800, Zorro Lang wrote:
> >> If kernel supports io_uring, userspace still can/might disable that
> >> supporting by set /proc/sys/kernel/io_uring_disabled=2. Let's set
> >> it to 0, to always enable io_uring (ignore error if there's not
> >> that file).
> >> 
> >> Signed-off-by: Zorro Lang <zlang@kernel.org>
> >> ---
> >>  common/rc | 3 +++
> >>  1 file changed, 3 insertions(+)
> >> 
> >> diff --git a/common/rc b/common/rc
> >> index 50dde313..966c92e3 100644
> >> --- a/common/rc
> >> +++ b/common/rc
> >> @@ -2317,6 +2317,9 @@ _require_aiodio()
> >>  # this test requires that the kernel supports IO_URING
> >>  _require_io_uring()
> >>  {
> >> +	# Force enable io_uring if kernel supports it
> >> +	sysctl -w kernel.io_uring_disabled=0 &> /dev/null
> >
> > _require_XXX functions are supposed to be predicates that _notrun the
> > test if XXX isn't configured or available.  Shouldn't this be:
> >
> > 	local io_uring_knob="$(sysctl --values kernel.io_uring_disabled)"
> > 	test "$io_uring_knob" -ne 0 && _notrun "io_uring disabled by admin"
> 
> That sounds like a good option to me.
> 
> > Alternately -- if it _is_ ok to turn this knob, then there should be a
> > cleanup method to put it back after the test.
> 
> I think it would be better not to change the setting, especially if the
> admin had disabled it.

As a testing environment/system, even if fstests doesn't touch the io_uring_disabled
sysctl, the testers should care about that before doing his test. So the fstests
users might need to change the io_uring_disabled=0 manually, or do it in their CI
test scripts. Maybe we should leave this job to the users.

Thanks,
Zorro

> 
> Cheers,
> Jeff
> 
> >
> > --D
> >
> >> +
> >>  	$here/src/feature -R
> >>  	case $? in
> >>  	0)
> >> -- 
> >> 2.43.0
> >> 
> >> 
> 
> 

