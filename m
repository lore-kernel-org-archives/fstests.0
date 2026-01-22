Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969943358AF
	for <fstests@vger.kernel.org>; Thu, 22 Jan 2026 07:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769066472; cv=none; b=rise/BtctA2CBMzH1bjou8qt0EltGncciK3+S2SvpWMDSoqn7Wtu9rkueiOUJocbDlwiim6jc7c3KzAdrgTQWnHbTeBCvtinv7hX6z0/+zWQ7xiZNNgAwA3tP7qHmL8BfSYNlLBsVCxuO0U7ox2iiiLQg7di7ZaPfJJmxo2BHqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769066472; c=relaxed/simple;
	bh=SxcONQsF6MjmeNPm6XPEu9NpglWa3Hf4iHN8GK7LgIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tm1XgD5NESUlYTK8vGSf1j8vJhBBsfia3jDI0FEYYLo2x7isqRKxHhMfSw+FhcgmP987zIvnhWPI4jHEFg7SeE441+AiNWqRwB4UlyA/+WsbJhxEo/wKt8SK/LmUoIiEz0ORZIFfOCIdJVEehPEmPLpkbeyGFAJOSkltpzDTu2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K48ZxM51; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dT3CEFE2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K48ZxM51";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dT3CEFE2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769066469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qslT+6XhgV1DLTYR/u+J/nSX2XrGFjhj3ShPzwpoNw0=;
	b=K48ZxM51jXC7dCScEpex6a51JbLUxeVYC/GtIKtUjq8qgi01dCboej8Gmju93rnJDyznd0
	o5mB7GdeSb+4cp6b1P8hY0EUUmW9N7Xj/53VxVd6T5nGYcSkoFo8zpbKbtBlF782AJZDH1
	wIu+TH1gyVeQtlPje7CQJj0SD2MvKkU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-HjrpjI2VMXy7gaf9t92IPw-1; Thu, 22 Jan 2026 02:21:07 -0500
X-MC-Unique: HjrpjI2VMXy7gaf9t92IPw-1
X-Mimecast-MFC-AGG-ID: HjrpjI2VMXy7gaf9t92IPw_1769066466
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c5d6193daso1332767a91.1
        for <fstests@vger.kernel.org>; Wed, 21 Jan 2026 23:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769066465; x=1769671265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qslT+6XhgV1DLTYR/u+J/nSX2XrGFjhj3ShPzwpoNw0=;
        b=dT3CEFE2QMmAqv/PM8iN+b3xh/LP5xJSXGUNUbe8f6pNfcz/R4cCpYs4qqbanT1pn4
         p1EhuZv6ICH9/IaRxXSFpNruJtOLFpj9W18Zq5BiJJWl+SN0KcG/B4m6Evb9lmyGDnma
         VRRIvjVWl8yNaMWeFfP0Lli/aRd2A/95Yp442xCt1VHK7aP8Hh67hZ51oye+6FkkspAU
         +ISmVTIQSDau6nQJtJHFuK56Us7S1Cf0mevLexiJJGcBMJe4Bd+TJu7M0GVMpZThH8Xl
         m93RFShvcocM8cp5KeZfpDLtRnIpT4cP1tEemr2ElMHLmC2MaovHSf+IptgqMNoxiLt+
         WODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769066465; x=1769671265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qslT+6XhgV1DLTYR/u+J/nSX2XrGFjhj3ShPzwpoNw0=;
        b=sckSe71qNW+ZgHws6YnyLMqNRephNTF3Zc82adCCCzp2kvUN6GkU+o4FfJKMXIfujd
         vIpVfoX488qS30H+lHG08FFJEnEMmD4KGNO/cHprxUKeVmDzBakAmQIVkhXt3E3AQ6gN
         unffq8Iad4kz7nFWiiDil5ZTci4F0/lt2taI9cCBV2PLzjht5YttL4Q/a8uXbB5arqoV
         CW4j0eL08JbMZ0T/vXPuvnIJAXz93uCUDoiIDLm432EzfSOXCwFBKb7r47430m3ypf5T
         oI7bWxvA/3h7JMSz4AfLlPFNfkmtBoT3P8xaKa4JK9nknnZhlara98yjUaJ7cX+hOeXc
         0+gg==
X-Gm-Message-State: AOJu0Yy4u83+/T3z6NgTI5J4IfuqkHGiVCG1q/SwAV2A4Uliejy1sRuQ
	QeJOumLkUXS4uHBBR/5S1iqxReQkzX9y9Ps5lyJaUfCJflcxK7psAWFmrophLS25JKG3JXZt5Ft
	6gZnHdrFB+e/wecSZ7M2A3j1++H332Pk3dmKPPixZPOSEZOnYJz6Zf1TGDdjuZpnIzuYhPw==
X-Gm-Gg: AZuq6aLTK+ZtQnGmmTW2W634VL5DwY4B/0EPqG+QA+1ZuDv+DDWovpUj2WI10tq4Dg+
	wM4kmthKRsKuxG2RI5UPswwSXYnDTDBKcg+oRXcRL5t6KxBF2yZg0hIgBbPrgGbBTAOA1b26qOV
	lvvwXFlU7z4f2iVv+DtmhfxchFv/ATDoIDMWfeKd8cQQcHjA93JbIynNtuard5KDVRd5+gLee6m
	7wNLb6xeidalAx5bfGUhwlBNlN7MD3Fiozy/N2FSrJfX6P+N1P9B2vU9clYusFnanDnkIdV00Zy
	chjYJ+Lvfm+umN8vWH+Y58YtF7HwobaegtWxPoRCAJM9t2a5oTI9QKbI1ha4nuXvavpHsWg6vpw
	dX5qprud9frtQxG7anH6SBr00ClyyVuEbiX0F5GOrTdp35zrPbg==
X-Received: by 2002:a17:90b:4a41:b0:352:fa96:5137 with SMTP id 98e67ed59e1d1-352fa96538emr4747865a91.21.1769066465515;
        Wed, 21 Jan 2026 23:21:05 -0800 (PST)
X-Received: by 2002:a17:90b:4a41:b0:352:fa96:5137 with SMTP id 98e67ed59e1d1-352fa96538emr4747838a91.21.1769066464961;
        Wed, 21 Jan 2026 23:21:04 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf2330d4sm16993342a12.5.2026.01.21.23.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 23:21:04 -0800 (PST)
Date: Thu, 22 Jan 2026 15:21:00 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests <fstests@vger.kernel.org>, xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] misc: allow zero duration for fsstress and fsx
Message-ID: <20260122072100.2aynewdegsdz7stz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260121012621.GE15541@frogsfrogsfrogs>
 <20260121155456.pf6jeprhzua3rdl3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20260121174601.GE5945@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121174601.GE5945@frogsfrogsfrogs>

On Wed, Jan 21, 2026 at 09:46:01AM -0800, Darrick J. Wong wrote:
> On Wed, Jan 21, 2026 at 11:54:56PM +0800, Zorro Lang wrote:
> > On Tue, Jan 20, 2026 at 05:26:21PM -0800, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > Occasionally the common/fuzzy fuzz test helpers manage to time
> > > something just right such that fsx or fsstress get invoked with a zero
> > > second duration.  It's harmless to exit immediately without doing
> > > anything, so allow this corner case.
> > 
> > Sure, duration=0 is harmless, I'm good with this patch.
> > 
> > Reviewed-by: Zorro Lang <zlang@redhat.com>
> > 
> > Please excuse my nitpicking. I'm curious about the semantics of "--duration=0".
> > Looking at the output of `fsstress -v --duration=0`, it doesn't actually
> > 'do nothing.' Instead, it behaves similarly to duration=1, where fsstress
> > attempts to execute operations before timing out and exiting :-D
> 
> Yeah, I suppose it's possible to do a very small amount of work.
> 
> Would you mind changing that last sentence to read "It's harmless to
> exit almost immediately having done very little work, so allow this
> corner case." prior to commit?

Sure Darick, I can make that change prior to commit :) But I was just
curious to hear your thoughts on:

  if (duration == 0) {
          /* No action is taken if duration is 0 */
          exit(0);
  } else if (duration < 0) {
          fprintf(stderr, "%lld: invalid duration\n", duration);
	  exit(88);
  }

do you feel that makes more sense semantically :)

Thanks,
Zorro

> 
> --D
> 
> > Thanks,
> > Zorro
> > 
> > > 
> > > Cc: <fstests@vger.kernel.org> # v2023.05.01
> > > Fixes: 3e85dd4fe4236d ("misc: add duration for long soak tests")
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  ltp/fsstress.c |    2 +-
> > >  ltp/fsx.c      |    2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> > > index c17ac440414325..b51bd8ada2a3be 100644
> > > --- a/ltp/fsstress.c
> > > +++ b/ltp/fsstress.c
> > > @@ -645,7 +645,7 @@ int main(int argc, char **argv)
> > >  				exit(87);
> > >  			}
> > >  			duration = strtoll(optarg, NULL, 0);
> > > -			if (duration < 1) {
> > > +			if (duration < 0) {
> > >  				fprintf(stderr, "%lld: invalid duration\n", duration);
> > >  				exit(88);
> > >  			}
> > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > index 626976dd4f9f27..4f8a2d5ab1fc08 100644
> > > --- a/ltp/fsx.c
> > > +++ b/ltp/fsx.c
> > > @@ -3375,7 +3375,7 @@ main(int argc, char **argv)
> > >  				exit(87);
> > >  			}
> > >  			duration = strtoll(optarg, NULL, 0);
> > > -			if (duration < 1) {
> > > +			if (duration < 0) {
> > >  				fprintf(stderr, "%lld: invalid duration\n", duration);
> > >  				exit(88);
> > >  			}
> > > 
> > 
> > 
> 

