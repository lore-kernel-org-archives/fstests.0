Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DBC11713
	for <fstests@vger.kernel.org>; Fri, 26 Sep 2025 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758886656; cv=none; b=ZBNkSmPAbYzmw1xIbjVsDmlY7hFVvPu4iORsnDBXJPsngadxiobhyjbyQPU/1+bPraCN2+n8XRf058nv+fjAOkCIHsVepjxCZ1plNiRNuFLN2UKimLzCP5nD1FnDETUc2ZWSa6Sx7bHtDwUTK0EJaE71xDaMKVmgmWZv1uQ52x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758886656; c=relaxed/simple;
	bh=hI8B5FVQJlKsq6wor2SKRm3c/p0i95tw41jHfYncIp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1lIBti1C8mAt8XUlWsuv1WLjtgLT+rG8SThaVc9jDU+0SVCsmCbSoTE9Sk1U/F7Ju4bUs08s+l2Wfo0GIv6+rCu1QedlI5K2cMbcbvbgc6yU17wnfltkkutFjnt8gZ49KAuMPoh3gaT9jOkdW3oPD84Xq+h+Odt3WR0GH6H38M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dcXqTnW9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dcXqTnW9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758886654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VJPk90ZhYWOeMEHpO3A7p3Rj1Lek87OJOkAVJpqn+Pc=;
	b=dcXqTnW92jFE3zOkmOggakrIT3B/Kq4z9Cr7OvbN0lyMK4HBkN2HLroVHnnXZm4nI3+oPD
	fCCK8Buqxbz7tlrjPFK9/KFTMYFtRrRUxVUuE0RSlwetGz0CtNnqVDsBxuOhVUCgQtZFOi
	8tD7rx6oCg05WHgM55jOjhGtUPLxBlA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-QrFtG6vtPlq8Kfb7cVlarw-1; Fri,
 26 Sep 2025 07:37:32 -0400
X-MC-Unique: QrFtG6vtPlq8Kfb7cVlarw-1
X-Mimecast-MFC-AGG-ID: QrFtG6vtPlq8Kfb7cVlarw_1758886651
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D9E318002C3;
	Fri, 26 Sep 2025 11:37:31 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.134])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD5E2300021A;
	Fri, 26 Sep 2025 11:37:30 +0000 (UTC)
Date: Fri, 26 Sep 2025 07:41:40 -0400
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: destroy loop dev before fallback recreation
Message-ID: <aNZ79FgR4aQJAy9-@bfoster>
References: <20250924181235.152502-1-bfoster@redhat.com>
 <20250925165046.GG8092@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925165046.GG8092@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Sep 25, 2025 at 09:50:46AM -0700, Darrick J. Wong wrote:
> On Wed, Sep 24, 2025 at 02:12:35PM -0400, Brian Foster wrote:
> > When running fstests on an s390x box I observed failure to unmount
> > filesystem errors due to stale loop devices being left around. This
> > root caused down to generic/361 leaving around an attached loop0
> > device. On further inspection, the test actually created two loop
> > devices (loop0 and loop1), and executed on and cleaned up the
> > latter.
> > 
> > The origin of the former appears to be that the initial losetup
> > command in _create_loop_device() fails due to $dio_args in this
> > environment, but still creates the loop device. For example:
> > 
> >  # losetup --direct-io=on -f --show /mnt/scratch/fs.img
> >  /dev/loop0
> >  losetup: /dev/loop0: set direct io failed: Invalid argument
> 
> Egad following the argument parsing in losetup is awful.  I had thought
> that the -f would set act == ACT_FIND_FREE which would then set up the
> loop device with one configure call, but the error message clearly
> indicates that we're failing here:
> 
> 	case A_SET_DIRECT_IO:
> 		res = loopcxt_ioctl_dio(&lc, use_dio);
> 		if (res)
> 			warn(_("%s: set direct io failed"),
> 			        loopcxt_get_device(&lc));
> 		break;
> 
> In this case, we clearly don't tear down the loop device after this
> failure, so yes, you've found a bug.  losetup can totally create a loop
> device, fail to configure it, and return EXIT_FAILURE without tearing
> down that loop device.
> 

Figured it was something like that after seeing how this was previously
a separate losetup command. I would have thought the same around error
handling, fwiw.

> >  # losetup -a
> >  /dev/loop0: [64771]:131 (/mnt/scratch/fs.img)
> > 
> > The helper then goes on to create loop1, but it or the test never
> > deals with loop0. To avoid this problem, detach any old loop device
> > if one was set up before the fallback losetup command.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> > 
> > This appears to be fallout from recent commit aa14b84a8d1a2 ("xfs/259:
> > try to force loop device block size"). I'm not really sure why losetup
> > creates the device with bad dio settings but not with block size. Maybe
> > it's more of a dynamic setting or whatever and that's why this was
> > previously a separate losetup command..? Anyways, this seems to work for
> > me..
> 
> It probably has to do with the underlying fs not supporting directio or
> something.  What fstype is /mnt/scratch, and which kernel version?

Eh, this was XFS IIRC on a custom RHEL kernel on s390x. I didn't take it
as far as testing upstream and/or digging further because it clearly
toggled on the recent losetup change.

> 
> > Brian
> > 
> >  common/rc | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/common/rc b/common/rc
> > index 81587dad..891f6b7e 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -4596,6 +4596,7 @@ _create_loop_device()
> >  	# size to the directio alignment of the underlying fs, so if we want to
> >  	# use our own sector size, we need to specify that at creation time.
> >  	if ! dev="$(losetup $dio_args $args -f --show $file 2>/dev/null)"; then
> > +		test -n "$dev" && losetup -d "$dev" > /dev/null 2>&1
> 
> The logic looks sound, but I think there ought to be a comment
> explicitly documenting this behavior of losetup:
> 
> 		# losetup can create a loop device, fail to configure
> 		# it, and return EXIT_FAILURE without tearing down that
> 		# loop device.
> 		test -n "$dev" && losetup -d "$dev" &>/dev/null
> 
> Because I won't remember this subtlety 3 months from now. :(
> 

Sure, I'll add something like that. Thanks.

Brian

> --D
> 
> >  		dev="$(losetup $args -f --show $file)" || \
> >  			_fail "Cannot assign $file to a loop device ($args)"
> >  	fi
> > -- 
> > 2.51.0
> > 
> > 
> 

