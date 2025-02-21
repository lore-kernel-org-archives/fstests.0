Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB48F33EA
	for <fstests@vger.kernel.org>; Fri, 21 Feb 2025 06:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740118193; cv=none; b=cOC9TmC4LTgY9KtO/BRT3JBPdcHxU7SWIcDYXaCpm/0bGHbinKh73shq6zTan9Mqir5wvH7l98gONEYeFZmomNFCIh/O2zmDMXOko9tcnd1OarNdXqCaWm6t7i4wa+8pWncC1yULzVOBY8EVzkXfJoiFbNEjb9Ddo7HMW/0groQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740118193; c=relaxed/simple;
	bh=n+5CPVi3CR7gH9gJgXpwP2lIPCsSM67YkkA9opZbwN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLmLCXEba2EcfpHjbXPbjrn/rlyEsZbiYt+PSXZ0z0t6XBwefG25L5GxpMYsjmXEa5vh5q5taJbeE43kXj6IXzog7eLFxU8fP0OFNM4Bs+SZUSzOqjHkBVRXcYMOAyKUDwcOkMrcm6ViNkR0JLxSXQQouCcel4/TSdA9Id+dsh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=azWIIEoA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azWIIEoA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740118188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bd83C4IoFAPicUSG0hi+EK6ZkQL9kloXMZ5jqLx6uOo=;
	b=azWIIEoAd6ENREpN18g8rwIV0dKkk9yE/h8ZnW0dEakAelg5mWzA7mg7n0DsV5B3q5N4Gt
	tP9zxFxQnFonMOmqAZ6vp4JJFOGBLh/poTyRz2WyT8wYTWIoKrKUspS4JOPrRxHi4kPjW8
	zWiOf2sF5JkAl8LjUE1Nzf3+teX8y04=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-s7ELN6pcOS-Y-Aj5VLKa2A-1; Fri, 21 Feb 2025 01:09:47 -0500
X-MC-Unique: s7ELN6pcOS-Y-Aj5VLKa2A-1
X-Mimecast-MFC-AGG-ID: s7ELN6pcOS-Y-Aj5VLKa2A_1740118186
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc3e239675so5650817a91.0
        for <fstests@vger.kernel.org>; Thu, 20 Feb 2025 22:09:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740118186; x=1740722986;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bd83C4IoFAPicUSG0hi+EK6ZkQL9kloXMZ5jqLx6uOo=;
        b=j7sA0k5IQDI55zK1E/r3L2Tyon0AL9FdE6NGA+DP4l9Y5Ut/2hsy4O36+JvbBuJnJR
         d6XQl/WEBcBHJpp3IaDmlEPeqensnLORwWcAjacxcgO6eoXIT2GCtHa2Xw4GWFlwqLZc
         gXF/RbmT1ILlVSNWY8vXEdqVtqvjjs6Jq9x1T0wIt5lA2y3Ily8+P5bgf6Qr+xhrxVgo
         2Zz6rRL/sANigbrsEvZbEnntfMRcBOoMHn5bGBijh5mOYvUI0TUnsol7XkbBdrPZlMlg
         Z3iyO7Z+hy0wiqCW5ehCLD9Mnm74nXBpm2CONZJIDTN63CIkSpamELd0qFKYWskaMoWj
         Mqfw==
X-Forwarded-Encrypted: i=1; AJvYcCUoGo2O2l0VGrAUjUWv09PzkYlMwf80BIyIZgDk0f6ZySs1g8hzzHcIgt8y6oL8URgkiCNIrUfm@vger.kernel.org
X-Gm-Message-State: AOJu0Yws8JVoCes3S0oCtTsfAR/SaBY7K7yVNXLCLNwL3wuNlLuCcGig
	lfNeD8HkdFDIcnd82Heo8UfgRD7bREBO+nH9k+JvZha6hPG9o+Txs5ZWXG8v5d9bl+LXrXVoOhK
	7KVAklhuxLwJfWO79V+31y2/KhSz1eLzj+JbQKe+aRnhO5hp9OMHTHvs=
X-Gm-Gg: ASbGnctJ6lxVlZzc2JSqFwNj7YK6M+LSRO/mnpqR1dQfznY0Xbn+Tu3wj3Qj2Eisih8
	89uDgNBXTfexMiJz05HlWK84YNeb0VBvi0ezJFHJEiVuF/bJtF5xwi3zSe1JUsZfA9zCjVeaEVR
	nCkBD/IjWvWrlDZ088gF6zq+d7NgiSgLWPSKCSnm4ZOZp7EiJe8uZu51uy+imkOCHxdu6uPvaPg
	KFxQTEqyGGctIAv/dWHa7IZkLvnjXJ98weZN2LKsfyczmfUFU4JbXzDbTUr3NAXpRA8vae55F7Q
	CGU7YMrKAs06Szxxi/zbFGEbEbhAKtakFk1NNzhP4r056TR8e3DIUpQq
X-Received: by 2002:a17:90b:4ac5:b0:2ee:f80c:6892 with SMTP id 98e67ed59e1d1-2fce868c624mr2513454a91.3.1740118186152;
        Thu, 20 Feb 2025 22:09:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlCxM88XnCWz5CtHp4Ei6DGMrpbqAWlS/AdMthkUikSvnop7fPK2linfOp4iu3kNKXuyhglA==
X-Received: by 2002:a17:90b:4ac5:b0:2ee:f80c:6892 with SMTP id 98e67ed59e1d1-2fce868c624mr2513431a91.3.1740118185868;
        Thu, 20 Feb 2025 22:09:45 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb04bedbsm480682a91.18.2025.02.20.22.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 22:09:45 -0800 (PST)
Date: Fri, 21 Feb 2025 14:09:41 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: Filipe Manana <fdmanana@kernel.org>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH 1/2] btrfs/254: don't leave mount on test fs in case of
 failure/interruption
Message-ID: <20250221060941.pyqwi4trggrvmbys@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1739989076.git.fdmanana@suse.com>
 <9aa6c8318d11b2fd1c2e208d85b2f83ea81ff88d.1739989076.git.fdmanana@suse.com>
 <d2d72753-5bf2-48cf-b2f0-cfe184ec75a7@oracle.com>
 <20250220170333.GV21799@frogsfrogsfrogs>
 <CAL3q7H6cH26jarU+YEogd5O5FuHi+YNtaWgmsV72NuXacPQU6w@mail.gmail.com>
 <bffa58e7-e34a-40ec-b0d9-368224dd22ab@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bffa58e7-e34a-40ec-b0d9-368224dd22ab@oracle.com>

On Fri, Feb 21, 2025 at 09:48:10AM +0800, Anand Jain wrote:
> On 21/2/25 02:22, Filipe Manana wrote:
> > On Thu, Feb 20, 2025 at 5:03 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > 
> > > On Thu, Feb 20, 2025 at 01:27:32PM +0800, Anand Jain wrote:
> > > > On 20/2/25 02:19, fdmanana@kernel.org wrote:
> > > > > From: Filipe Manana <fdmanana@suse.com>
> > > > > 
> > > > > If the test fails or is interrupted after mounting $scratch_dev3 inside
> > > > > the test filesystem and before unmounting at test_add_device(), we leave
> > > > > without being unable to unmount the test filesystem since it has a mount
> > > > > inside it. This results in the need to manually unmount $scratch_dev3,
> > > > > otherwise a subsequent run of fstests fails since the unmount of the
> > > > > test device fails with -EBUSY.
> > > > > 
> > > > > Fix this by unmounting $scratch_dev3 ($seq_mnt) in the _cleanup()
> > > > > function.
> > > > > 
> > > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > > > ---
> > > > >    tests/btrfs/254 | 1 +
> > > > >    1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/tests/btrfs/254 b/tests/btrfs/254
> > > > > index d9c9eea9..6523389b 100755
> > > > > --- a/tests/btrfs/254
> > > > > +++ b/tests/btrfs/254
> > > > > @@ -21,6 +21,7 @@ _cleanup()
> > > > >    {
> > > > >      cd /
> > > > >      rm -f $tmp.*
> > > > > +   $UMOUNT_PROG $seq_mnt > /dev/null 2>&1
> > > 
> > > This should use the _unmount helper that's in for-next.
> > 
> > Sure, it does the same, except that it redirects stdout and stderr to
> > $seqres.full.
> > 
> > Some tests are still calling  $UMOUNT_PROG directly. And that's often
> > what we want, so that if umount fails we get a mismatch with the
> > golden output instead of ignoring the failure.
> > But in this case it's fine.
> > 
> > Anand, since you've already merged this patch into your repo, can you
> > please replace that line with the following?
> > 
> > _unmount $seq_mnt
> > 
> 
> Applied.
> Thanks.
> 
> Zorro,
> 
> Just checked, and it looks like you haven’t pulled in patches
> from my for-next yet.
> I went ahead and force-updated it to keep unnecessary noise
> off the ML.
> 
> If you're pulling this weekend, there are three patches in
> for-next ready to merge.

Actually I've pulled, just haven't pushed :) Then I saw this conversation, so
I'm going to reset and re-pull. The next release is nearly done, I'll pick
up more simple patches with RVB today, then prepare to release it. Thanks!

Thanks,
Zorro

> 
> ( https://github.com/asj/fstests.git for-next.)
> 
> 
> Thanks!
> Anand
> 
> > Thanks.
> > 
> > > 
> > > --D
> > > 
> > > > >      rm -rf $seq_mnt > /dev/null 2>&1
> > > > >      cleanup_dmdev
> > > > >    }
> > > > 
> > > > 
> > > > Reviewed-by: Anand Jain <anand.jain@oracle.com>
> > > > 
> > > > 
> > > > 
> 

