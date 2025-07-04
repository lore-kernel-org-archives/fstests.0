Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3383596B
	for <fstests@vger.kernel.org>; Fri,  4 Jul 2025 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751653828; cv=none; b=uH9Ig43HQ/5PnM5DGzZfIwRvltYTF7vveckOHT1rQor4/XG/WCfiFRmHeMtSp9D0QtAtFofOiE0MhLka1haXIhDYQhipVNu1eCkI9dLna4+6WCeXBrmaUsF6u/p35HbJzNdwSTMcsIRNMfeYpAtk6tLYuUdvcC2zH/6cQUBCll0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751653828; c=relaxed/simple;
	bh=vVHA5joY6IcGy7tC7wV6vefYzCBMz0qLNhnYoagx0xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5bwoJUBRgjZwbfhygzUrC6NwOugZXmA9YwwZ7a24oiCRzun0ere9cr8KOowU0WiMTlD51ycmeICO+CLqvnd3x09WAglONYkuSGiJ6+inY15LWBXjWSO5ZLxjkDSWyKnrb10fGF8IPuzgocfJxxRRTRK0VtSuUHG+T/KxCs15Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yd0voYw0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yd0voYw0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751653825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbhYGUKt21vSsvrvlY5/+X1CqwX2FHTTRQfj9BKsHGw=;
	b=Yd0voYw0rKY7aIqQmClaxdYYRz23o9gXrzW9Jxi46MxcFGFTwSLaAeCkaA2GHuRJptYZZX
	wwSjMTu/zrFN1nb4C46+30TAi49XD1vudX50u4rtQIdH3BVmdu0C8GIfT+2OE3WHx3qOlX
	GOXnTHxkjch8dmA+UdaH4c1TuguTiRw=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-l28HLaHJNQyMO5DFjdrCaQ-1; Fri, 04 Jul 2025 14:30:22 -0400
X-MC-Unique: l28HLaHJNQyMO5DFjdrCaQ-1
X-Mimecast-MFC-AGG-ID: l28HLaHJNQyMO5DFjdrCaQ_1751653822
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b2c37558eccso994783a12.1
        for <fstests@vger.kernel.org>; Fri, 04 Jul 2025 11:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751653821; x=1752258621;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbhYGUKt21vSsvrvlY5/+X1CqwX2FHTTRQfj9BKsHGw=;
        b=HTQsliAhvJh43dEog3IzcM1ScRmizzYF6WCTGX3kG7HpnTilCc33zWs6/6ka/JQ7K2
         A1+X9JtBAnX981SJjGVk8QuVjMeusaiiZH9ut98bKBBgytKyTiCBeNr1tpbv+dOu5Fln
         l6Z0tkmD4lcRu3Phf5QdOBD0CfU3NF+lIer7HYhOBb+59mDNfvzJMSz11sWQwrDIntwv
         CuRkUDFnWU0ZAbho3ZHmtvMYi5GX6PP+bCMvrpMZQSzCEvlMpeVmpGQCFku2N2vdhUqL
         UK4PW50jrhsTzxJJAkxD5/UiX/y0EqIt4tODsPlfTfMo6JRngqp/u+YKqvUvtjzCSaId
         fZTQ==
X-Gm-Message-State: AOJu0YyUUrhkQOBkKpfKwVOiIamSk0Mq9Mf3anLxVlKX5XkpXsPI6P4U
	aoiiFulAWo7ALWScPc0AOmBDQemsiXTxGIw4j2JSa/zfv00ezeXR8J4RKQ+ZZxP8lqV5rieRhmB
	7oVTxhmycPrFWeisDCTLWXMgAd8BmuJjleh2YKivdl9TlFe+cwYcbaL8+R97D9BUXOFY=
X-Gm-Gg: ASbGncvTCiZN5caUSnIKHnn0GgsiPW45zcQBa57YcNJxRUrTabTMC0oCtl8K/azyZGn
	JbL8m+Va9sUe7X/0a9YZD1q8xoYMMCEZBihNFCRQqgSS0VhSlu7N9ww1hrw3RSrs/WhG32aG/Rt
	X2vmFfmwJ5uffgOwmSPQ2M/JK9SQ5yOTXBGzRG7s/wzV6FQ+/fqYzyHlVluUEaXCUcMKDnAQRe+
	hxw126XO8xByn9xEg+EUCl5Zhy5h9Q4Kcc43EVHQrTQoPA2c0+OPGvz+azbr1m+5xD69heoUspf
	qiJi8lQB9iJ7v6RDCOj6vODkL6605LKcvHhLu5QkqdJELT2D4meI2Je/h9DGnOA=
X-Received: by 2002:a17:90a:e18c:b0:311:c970:c9bc with SMTP id 98e67ed59e1d1-31aac53e092mr5110129a91.30.1751653821512;
        Fri, 04 Jul 2025 11:30:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP2Y0eWmCqueC8tDvUEnjDevhuNatGJ+2lvHHUenAh9gh4jAfLhteOmz1cOYIyag5h9l2T2A==
X-Received: by 2002:a17:90a:e18c:b0:311:c970:c9bc with SMTP id 98e67ed59e1d1-31aac53e092mr5110107a91.30.1751653821073;
        Fri, 04 Jul 2025 11:30:21 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31aaae81c0esm2639666a91.22.2025.07.04.11.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 11:30:20 -0700 (PDT)
Date: Sat, 5 Jul 2025 02:30:16 +0800
From: Zorro Lang <zlang@redhat.com>
To: Glass Su <glass.su@suse.com>
Cc: fstests@vger.kernel.org, Su Yue <l@damenly.org>, gfs2@lists.linux.dev
Subject: Re: [PATCH] common/quota: adjust _qmount_option for gfs2
Message-ID: <20250704183016.ib2a7c22g4amcywf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250603041009.59811-1-glass.su@suse.com>
 <20250620173839.q735lweoglone5cp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <089C8762-DDC0-45F6-8769-FD52A75CA626@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <089C8762-DDC0-45F6-8769-FD52A75CA626@suse.com>

On Tue, Jun 24, 2025 at 09:38:59AM +0800, Glass Su wrote:
> 
> 
> > On Jun 21, 2025, at 01:38, Zorro Lang <zlang@redhat.com> wrote:
> > 
> > On Tue, Jun 03, 2025 at 12:10:09PM +0800, Su Yue wrote:
> >> gfs2 supports mount options 'quota=[off/account/quiet/on]' but
> >> 'usrquota' and 'grpquota' are unsupported.
> >> So in _qmount_option, transform $OPTS to 'quota=on' first.
> >> 
> >> Signed-off-by: Su Yue <glass.su@suse.com>
> >> ---
> >> common/quota | 7 +++++++
> >> 1 file changed, 7 insertions(+)
> >> 
> >> diff --git a/common/quota b/common/quota
> >> index a51386b1dd24..4b8052e07dde 100644
> >> --- a/common/quota
> >> +++ b/common/quota
> >> @@ -283,6 +283,12 @@ _qmount_option()
> >> {
> >> OPTS=$1
> >> 
> >> + if [[ "$FSTYP" == gfs2 ]]; then
> >> + OPTS=`echo $OPTS \
> >> + | sed   -e 's/usrquota/quota=on/g' \
> >> + -e 's/grpquota/quota=on/g'`
> >> + fi
> > 
> > There's not response from gfs list. I'm not familiar with gfs2, so I have to
> > ask some questions about your patch...
> 
> Feel free to communicate : )
> > 
> > From the manual of gfs2:
> >  quota=[off/account/on]
> >  Turns quotas on or off for a filesystem. Setting the quotas to be in the "account" state causes the per UID/GID usage statistics to be correctly maintained by the filesystem, limit and warn values are ignored. The default value is "off".
> > 
> > Looks like there's only one mount option "quota=..." for gfs2. And I didn't
> > find a description about project quota, so
> > 1. What will gfs2 do if there's a "prjquota" or "pquota"?
> 
> The mount will fail if prjquota/pquota is in mount options.
> _require_prjquota() should be modified.
> 
> > 2. Do you need to replace "noquota" with "quota=off"?
> 
> Yes.. I forgot the case.
> 
> > 3. And "quota" to "quota=on" ?
> 
> The only case "_qmount_option ‘quota’” is tests/xfs/820, not in generic group.
> 
> > 4. Have you tried your patch on gfs2, can all quota related generic cases pass/notrun
> >   on gfs2?
> > 
> 
> TBH, not all quota tests run well on gfs2
> There was a bug which can cause kernel hang in gfs2 fixed by kernel commit 5a90f8d49922 ("gfs2: Don't start unnecessary transactions during log flush”)
> In v6.16-rc1.
> 
> > BTW, in this function you can see:
> >        # ext4 doesn't _do_ "-o pquota/prjquota" because reasons
> >        # Switch it to "quota" to enable mkfs-time pquota
> 
> The comment is confusing to me. ext[234] support ‘-o prjquota’ if  MKFS_OPTIONS="-O quota -E quotatype=usrquota:grpquota:prjquota”.
> 
> >        if [[ "$FSTYP" == ext[234] ]]; then
> >                OPTS=`echo $OPTS \
> >                | sed   -e 's/\bpquota/quota/g' \
> >                        -e 's/prjquota/quota/g'`
> >        # ocfs2 doesn't support "-o projquota"
> >        elif [[ "$FSTYP" == ocfs2 ]]; then
> >                OPTS=`echo $OPTS | sed -e 's/prjquota//g'`
> >        fi
> > 
> > please move your gfs2 specific codes here ^^, and give it enough comments.
> 
> There is one question from me about the _qmount_option() and _qmount()
> 
> Not all tests of qgroup use _qmount, some of them call _scratch_mount() directly.
> Is this intentional to avoid influenced by other mount options? If It’s not IMO it’s feasible
> to convert them to _qmount?

Except some xfs specific cases, I think only g/537 and g/230 don't use _qmount
directly.

$ for f in `grep -rsnl _qmount_option tests/`;do grep -wq _qmount $f||echo $f;done|grep -v xfs
tests/generic/537
tests/generic/230

By checking these two cases, I think their code logic can work well without
_qmount currently. But if you find some cases fail on gfs2, please feel free
to convert them to _qmount or fix them in your way :)

Thanks,
Zorro

> 
> > 
> >> +
> >> # Replace any user defined quota options
> >> # with the quota option that we want.
> >> # Simplest to do this rather than delete existing ones first because
> >> @@ -300,6 +306,7 @@ _qmount_option()
> >> -e 's/\bpquota/QUOTA/g'    \
> >> -e 's/prjquota/QUOTA/g'    \
> >> -e 's/noquota/QUOTA/g'     \
> >> + -e 's/quota=[^, ]*/QUOTA/g' \
> > 
> > I think you might need a word boundary, e.g. "\bquota=..."
> 
> Right.
> — 
> Su
> > 
> > Thanks,
> > Zorro
> > 
> >> -e 's/quota/QUOTA/g'       \
> >> -e 's/uqnoenforce/QUOTA/g' \
> >> -e 's/gqnoenforce/QUOTA/g' \
> >> -- 
> >> 2.48.1
> 
> 

