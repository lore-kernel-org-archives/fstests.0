Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C359014F61
	for <fstests@vger.kernel.org>; Mon, 26 Feb 2024 02:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708916199; cv=none; b=Xo5E8/eMcNSdIDYNd6xAIFLRWG7YbuF5mmQYMV82HKaVXNDL0bbGyR5DD23juYn6/GtnIbpzgcpqJtWDn0KdruVmO0UFlg4VhFbb8qnQvQFMFJVvmo0cRaBWYQDOPhYQlcLfKb1GfZyr/OUxW+TD/M855W21LOVRrHPdN35WE5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708916199; c=relaxed/simple;
	bh=mxG1I/Hb7Fer+y0+U2CCj7lr/LdaA6nNQnIMEUf2msQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HN6KU6DYu4cKtkKQmEkAx8I72MuZtUWM0aR4IjWU7KkqtcLOUeSwIUzYwPnLe0dU724GVkq68TsoVbfboniZH6kHhYaQ73o7hfCWaOZYBScljmc0HrsxdJBzqapkj9fQntR2W6rHyTa4keX7bibTBnn00va/ZDmLbPAloT7J0kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M8pSGay5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8pSGay5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708916196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3AV4jsdAVnCPwX4Ix7SjTP9x3dUcnrkx4AqOlb+A8Ok=;
	b=M8pSGay5K1KchF3OiLznJvgxMmCHGXo+R+jfeg0zNumvlII39hLKpYWBLDDjKhXf2/V1Tk
	u6+gZu8dQe823tEIl35qVwuvoPYToxyzubUgc1LdLxjHybkowkBqFbdFPWZQpHFm8PuAj3
	p8GFOLOgj+UMXu+wJi5S70Ilx06GrnI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-naiXo9xWNZmR7O44U8Wn1g-1; Sun, 25 Feb 2024 21:56:34 -0500
X-MC-Unique: naiXo9xWNZmR7O44U8Wn1g-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5cf555b2a53so1024181a12.1
        for <fstests@vger.kernel.org>; Sun, 25 Feb 2024 18:56:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708916194; x=1709520994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AV4jsdAVnCPwX4Ix7SjTP9x3dUcnrkx4AqOlb+A8Ok=;
        b=sNB7xOYzXFgigRMFc1Xgpybe1boOzJ0bKXlMB3pME9eJALF2Zlw3W6SVLAwWwhLWzg
         04NdUx35LU/HJ858U/Gxft9TPX8VKXHugyZwEowvMeXyaENHwyiP893ptNztajMShaju
         FeREvfz92iJB9F0/ZaToBXXfKSqvp+pCw2TFt20gacTiKtFVvi5DEqvB9XwUymACpnnC
         vYUSTAP7yS/G5Sivz4lue5Pd4FbMaNSu9k1VcXM7yYgV60bClo3iwwDsZ/FSZUW5caMf
         Y3w4jWojq/yCswuvioV3KyfUvI/KysIfDqXK49OJj60bYegY3poaab4TaDnoNmr0dkiu
         sOTg==
X-Forwarded-Encrypted: i=1; AJvYcCUn+M7GcEvhwxCHlsRc089iLb0y/lfonNpZWgOEmRxFxoCqJcJjn5uG8WEBSrQvMnXP/J8YtmllMF77N3sI0TRIYIdXE0GovA==
X-Gm-Message-State: AOJu0YxT7A4Bb+tygVj6p/dvTeZA8lR/pm+dCmrl2dY3DBe+yEvTGpUM
	aV4I6CEIRDBZYbcnzs/+ihZaQZH0jwFM9v5DawojkpYFANK9YS+IT6tbhB37bZvd2GAi4kT5G5f
	X56k6HsIVUMfSvEd9Dfi33ZxjcAk2ZrrNNgztNMeppKSFgDJtyr2LzJ8=
X-Received: by 2002:a17:903:1cd:b0:1dc:876d:7b1e with SMTP id e13-20020a17090301cd00b001dc876d7b1emr6191580plh.2.1708916193819;
        Sun, 25 Feb 2024 18:56:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGpJmrHkGC/NSN3+vfRQDFlEO1sO1mVjr+5tyw12kEjXAplrQcEci4CZjOhWukNFPZkpmzrw==
X-Received: by 2002:a17:903:1cd:b0:1dc:876d:7b1e with SMTP id e13-20020a17090301cd00b001dc876d7b1emr6191569plh.2.1708916193478;
        Sun, 25 Feb 2024 18:56:33 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a4-20020a1709027d8400b001d944b3c5f1sm2825701plm.178.2024.02.25.18.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 18:56:33 -0800 (PST)
Date: Mon, 26 Feb 2024 10:56:29 +0800
From: Zorro Lang <zlang@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, David Sterba <dsterba@suse.cz>,
	fstests@vger.kernel.org
Subject: Re: Dangerous commands (was:[ANNOUNCE] fstests: for-next branch
 updated to v2024.02.04)
Message-ID: <20240226025629.2a2dn6fksjywyqjz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240221140951.GJ355@suse.cz>
 <20240225151616.owk5v4ioplhrioe6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240225165128.GA1128@sol.localdomain>
 <20240225170304.GO6188@frogsfrogsfrogs>
 <20240225174527.GB1128@sol.localdomain>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225174527.GB1128@sol.localdomain>

On Sun, Feb 25, 2024 at 09:45:27AM -0800, Eric Biggers wrote:
> On Sun, Feb 25, 2024 at 09:03:04AM -0800, Darrick J. Wong wrote:
> > On Sun, Feb 25, 2024 at 08:51:28AM -0800, Eric Biggers wrote:
> > > On Sun, Feb 25, 2024 at 11:16:16PM +0800, Zorro Lang wrote:
> > > > On Wed, Feb 21, 2024 at 03:09:51PM +0100, David Sterba wrote:
> > > > > Hi,
> > > > > 
> > > > > reading [1] and how late it was found that effectively a "rm -rf /" can
> > > > > happen makes me worried about what I can expect from fstests after git
> > > > > pull. Many people contribute and the number for custom _cleanup()
> > > > > functions with unquoted 'rm' commands is just asking for more problems.
> > > > > 
> > > > > [1] https://lore.kernel.org/all/20240205060016.7fgiyafbnrvf5chj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
> > > > > 
> > > > > Unquoted arguments in shell scripts is IMO a big anti-pattern,
> > > > > unfortunately present everywhere in xfstests since the beginning.
> > > > > Rewriting all scripts would be quite a lot of work, could you at least
> > > > > provide safe versions of the cleanup helpers?
> > > > 
> > > > Hi David,
> > > > 
> > > > Thanks for taking care about it :)
> > > > 
> > > > > 
> > > > > For example:
> > > > > 
> > > > > _rm_tmp() {
> > > > >     rm -rf -- $tmp
> > > > 
> > > > It's "$tmp.*"
> > > > 
> > > > May I ask what problem does the "--" hope to avoid? If the "$tmp" is empty,
> > > > "rm -rf" and "rm -rf --"" looks like both doing nothing. So what kind
> > > > of situation does the "--" hope to fix?
> > > > 
> > > > The root problem in above [1] is about "${FOO}*". If someone does "rm -rf ${FOO}*"
> > > > in its custom _cleanup_xxxxx function, then it's dangerous if "$FOO" is empty.
> > > > 
> > > > I thought some ways to avoid that:
> > > > 1) Try to avoid doing rm -rf ${FOO}*, if not necessary.
> > > > 2) Must checks [ -n "$FOO" ] before doing any rm -rf ${FOO}*
> > > > 3) Someone's custom _cleanup_xxxxx better to be called before default _cleanup
> > > > does "cd /".
> > > > 4) Think about bringing in someone "Static program analysis" tool about bash
> > > > script, but I don't know if there're someone good, feel free to give me
> > > > suggestions.
> > > 
> > > "--" prevents the following arguments from being interpreted as options if they
> > > begin with "-".  That's a good practice, but it doesn't help with ${FOO} being

Thanks Eric, I know "--" can do that, just didn't understand how it helps the
empty variable problem. So looks like it doesn't.

> > > empty.  To cause the script to exit if ${FOO} is empty, it can be written as
> > > ${FOO:?}.  Alternatively, 'set -u' can be used.
> > 
> > I said that four days ago.  Did nobody receive that reply?
> > 
> > https://lore.kernel.org/fstests/20240225165128.GA1128@sol.localdomain/T/#m0efd851c5a1fb0dbe418f4aff818d20f4355638b
> > 
> 
> You didn't mention the :? option, and I thought that would be worth mentioning.

Actually:

[ -n "$FOO" ] && rm -rf ${FOO}*

or

rm -rf ${FOO:?}*

Both of them are good to me, depends on what's expected. The 1st one ignore empty $FOO and
keep running, the 2nd one breaks case running if $FOO is empty.

But they all need the programer to realize that his variable might be dangerous if
it's empty, and write as that. So it still depends on the programer or the reviewers
to notice that.

Thanks,
Zorro

> 
> Of course ideally -u would be used everywhere, as you said.
> 
> - Eric
> 

