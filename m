Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BBC13ADC
	for <fstests@vger.kernel.org>; Mon, 26 Feb 2024 02:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708914341; cv=none; b=RPHZ7vf8F7l5ttdDxnClj0kVisTpeeh5g3rpCX7QnWHnxfk01wVTUi3Q+6wi/WaSDlR51UC17aLoJ8tofcEwkc5Yal5x+0pxBiUtvUd0X4gV3oVNfUSG9u6RF1qCYqWpIIafmeO2qAShp6SoImy6v2wF1Pz5sFqkc6JTiYsb6eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708914341; c=relaxed/simple;
	bh=D45Wwjd1wathT4r9AiMRte1fivGns+onfkbfA6eZLgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojKihtb03pEAHFs1MrVZFGBXfNML0jjN42oA+fnuBEgo/Qh/YQtjb/kdK/LzT+L7D3oWofYgmkjRROXa8UUJXKiwH81NI7GTYNlx8MlzXQynidsWwTCcIEie9f5sJKgnioCiWJRwzQs3eByWrgWFtBsb3d1KaVElmH0IPngIaLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TYrXqQpm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYrXqQpm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708914338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D9MIXKCA5y07BWhNrXIXdxgg3putnqpmhbxErUQWVtE=;
	b=TYrXqQpm/Ob5qVGio8cZIuvzMxnWWXU/vZ6Z/Yy7FSbToPQQDVtBjRrPQ8WdntCylhNj5j
	xYx+BscnLbB4IuHD6LbRgjgn7bxJ1jFx9nRabGFRzZgDpwI1pdi9ggmX0/GzwPCOEs0s3M
	WIGnUzqmfGSf2rSsZ9pazZZ7iXjMGsM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-eWle2y7wMFCkapfaWtAsPg-1; Sun, 25 Feb 2024 21:25:36 -0500
X-MC-Unique: eWle2y7wMFCkapfaWtAsPg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5d1bffa322eso2626847a12.1
        for <fstests@vger.kernel.org>; Sun, 25 Feb 2024 18:25:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708914335; x=1709519135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9MIXKCA5y07BWhNrXIXdxgg3putnqpmhbxErUQWVtE=;
        b=jFWWYtWzBoor6Du/CT0Gjnt5Ds+zNdIo+sj0zao1kHHAxOvVBHzmJTYVw03l6FJlH8
         0DyVTNIQqVTxsJQedl/FKjBRVwcX9/hUBxTEhnUytuqxNfEvW5U4tDBdGan4GJyIwOv1
         QIviRwXwAxcR7o33Q1P6Hme2Jnasd97spb5pcLsZ2GKp/GVtKS344+0X76PB8mm2BHMI
         Jg9JImg1S/0p254Tust4jaP2VuBeMQ6eNmOymtX7515MKS+o8ZDtNwyRNA5x1cN+Or9T
         jgexONppaYaO9Z20uedCxGm9dPQPs3DRrZAbLteZIsSlYdFTxy+LdJ5+KgnDWNkXxsbz
         hSgA==
X-Forwarded-Encrypted: i=1; AJvYcCU0ELpfHz0/bLeuAWOdjgHyXX1HShe/uxO8BDQRoJSviHrTxh9xtIeSmVyXP+LkGdX7sfqUMVyClMLkkn+NZfa/lz8UOFv1TA==
X-Gm-Message-State: AOJu0YyNVTW6L0a8sQQO5ArEQK1i15HaJcO55I85jyYRC3CtQL0fckUT
	1lRO7qyi2cqKypB+PtaFxIoe8W7eZUxVYH6sXEfP9pPw3s9k5EzBCBuuM3qHBqetvZk6bQv+Arq
	xdTKqqRHFCiEuDLqB4BD+R6U09eX2UTy3jx4//bwedmi5LX3PtAm8M7Y=
X-Received: by 2002:a05:6a20:c906:b0:1a0:cf1f:aa91 with SMTP id gx6-20020a056a20c90600b001a0cf1faa91mr8487235pzb.25.1708914335180;
        Sun, 25 Feb 2024 18:25:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkKTvtBoKGKQfZzspvdRV04yWuUNlRxe8wl8BgGlrfpJIoNCXEkzCXE7Hlj2J+EZj46R+PyQ==
X-Received: by 2002:a05:6a20:c906:b0:1a0:cf1f:aa91 with SMTP id gx6-20020a056a20c90600b001a0cf1faa91mr8487223pzb.25.1708914334852;
        Sun, 25 Feb 2024 18:25:34 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id gu5-20020a056a004e4500b006e31f615af6sm2991723pfb.17.2024.02.25.18.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 18:25:34 -0800 (PST)
Date: Mon, 26 Feb 2024 10:25:30 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, David Sterba <dsterba@suse.cz>,
	fstests@vger.kernel.org
Subject: Re: Dangerous commands (was:[ANNOUNCE] fstests: for-next branch
 updated to v2024.02.04)
Message-ID: <20240226022530.p5scztsjhkb2dmer@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240221140951.GJ355@suse.cz>
 <20240225151616.owk5v4ioplhrioe6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240225165128.GA1128@sol.localdomain>
 <20240225170304.GO6188@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225170304.GO6188@frogsfrogsfrogs>

On Sun, Feb 25, 2024 at 09:03:04AM -0800, Darrick J. Wong wrote:
> On Sun, Feb 25, 2024 at 08:51:28AM -0800, Eric Biggers wrote:
> > On Sun, Feb 25, 2024 at 11:16:16PM +0800, Zorro Lang wrote:
> > > On Wed, Feb 21, 2024 at 03:09:51PM +0100, David Sterba wrote:
> > > > Hi,
> > > > 
> > > > reading [1] and how late it was found that effectively a "rm -rf /" can
> > > > happen makes me worried about what I can expect from fstests after git
> > > > pull. Many people contribute and the number for custom _cleanup()
> > > > functions with unquoted 'rm' commands is just asking for more problems.
> > > > 
> > > > [1] https://lore.kernel.org/all/20240205060016.7fgiyafbnrvf5chj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
> > > > 
> > > > Unquoted arguments in shell scripts is IMO a big anti-pattern,
> > > > unfortunately present everywhere in xfstests since the beginning.
> > > > Rewriting all scripts would be quite a lot of work, could you at least
> > > > provide safe versions of the cleanup helpers?
> > > 
> > > Hi David,
> > > 
> > > Thanks for taking care about it :)
> > > 
> > > > 
> > > > For example:
> > > > 
> > > > _rm_tmp() {
> > > >     rm -rf -- $tmp
> > > 
> > > It's "$tmp.*"
> > > 
> > > May I ask what problem does the "--" hope to avoid? If the "$tmp" is empty,
> > > "rm -rf" and "rm -rf --"" looks like both doing nothing. So what kind
> > > of situation does the "--" hope to fix?
> > > 
> > > The root problem in above [1] is about "${FOO}*". If someone does "rm -rf ${FOO}*"
> > > in its custom _cleanup_xxxxx function, then it's dangerous if "$FOO" is empty.
> > > 
> > > I thought some ways to avoid that:
> > > 1) Try to avoid doing rm -rf ${FOO}*, if not necessary.
> > > 2) Must checks [ -n "$FOO" ] before doing any rm -rf ${FOO}*
> > > 3) Someone's custom _cleanup_xxxxx better to be called before default _cleanup
> > > does "cd /".
> > > 4) Think about bringing in someone "Static program analysis" tool about bash
> > > script, but I don't know if there're someone good, feel free to give me
> > > suggestions.
> > 
> > "--" prevents the following arguments from being interpreted as options if they
> > begin with "-".  That's a good practice, but it doesn't help with ${FOO} being
> > empty.  To cause the script to exit if ${FOO} is empty, it can be written as
> > ${FOO:?}.  Alternatively, 'set -u' can be used.
> 
> I said that four days ago.  Did nobody receive that reply?
> 
> https://lore.kernel.org/fstests/20240225165128.GA1128@sol.localdomain/T/#m0efd851c5a1fb0dbe418f4aff818d20f4355638b

Sorry Darrick, I've noticed your reply. About the "set -u", it helps to avoid
empty variables, but the question is when should we set it. If we set it at
the beginning of each case, won't it affect too much? Some cases might don't
mind empty variables, but this setting might cause some cases fail. The
programmers might want to decide if they accept empty variables by themselves?

Thanks,
Zorro

> 
> --D
> 
> > - Eric
> > 
> 

