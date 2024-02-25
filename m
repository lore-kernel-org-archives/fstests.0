Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548E517991
	for <fstests@vger.kernel.org>; Sun, 25 Feb 2024 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708874187; cv=none; b=eq97JlPU0g6XTrJG7CI4zyENxPVPQXmPuAWKW4Bz87pCiHIoFlZuEehYwWFzPw2rGVKXjzJO4YE9jWQo6IQ+8NOcdtvPxP7VGko41rcCYfkH6VXbUzLBKudKhy92JM+sl5IETPOfwfzQ/d/WTIjce7t0Me8UhGSlqpTGBIDJXkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708874187; c=relaxed/simple;
	bh=oO66jRicjwIgxs/QAggbE42TS3XjYg/8FvrEkHvO2yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2VXHRPUQK+C4QIEWvHZJe4IU5F3sJzloIwnQu0CDjSCiPbFMrjmZh/fViVHvmtYK66ccRCAv/1jMmQE71qYbnqbOPkv2rR2JX/QBX5n/iPss81KgSUSBp3JHO6Alh4EeCZsZG1GFrWQQNwRIg3t1RgtAMzWNNSpR15YQvPauUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FPPdOUKH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FPPdOUKH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708874184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qA2rpmLN1OGofh/yzE09y5VKDuVkZzuaXCWipYuWZqo=;
	b=FPPdOUKHNQnuaXV6hJt7gL31P6bABaRwsKr6CfKXPQseAD2xmUbP9gl5VC3ona8PamwA0g
	vhTXcM86OjdMIC2AIc5boBG92S51J1rHvIVnLrKet+T9thF05XxyeZA9p55ITxLBIxPrNq
	jMyfcNQrXhNXI+WDD/7vdrfidcBRXw8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-xDKsagJRNwG7_haxJO7EGQ-1; Sun, 25 Feb 2024 10:16:22 -0500
X-MC-Unique: xDKsagJRNwG7_haxJO7EGQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-290e7a0a585so1941822a91.3
        for <fstests@vger.kernel.org>; Sun, 25 Feb 2024 07:16:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708874181; x=1709478981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qA2rpmLN1OGofh/yzE09y5VKDuVkZzuaXCWipYuWZqo=;
        b=eOpG/SQQQ9vIq+t2oZpxBTGi4BXwfo1ieYMTk7MP4fn7r5iEhh2Z3HF0taDSm/1gA2
         zSKBHI/BxO3kdT/JoIy/VD4RsaFUG2TV0m5+4DEW/vw6MTU9lX9+rnkvW/bBg/akfMxX
         cv2oBcrQlraNekc0F4vGyfpM17y0Zb9xncwVCvP31LUQsziTFwrvOUKArKbOKItwQ0uV
         ZkXdphymosv3nzQ4acuzOVClCxKAP8x7I2bbV1DN+KyNGHGlmIIw9CtmU0L1IsKzUAcz
         46cFDY5ffrOLczJm9+HFbqk3BWr4c4suVGAE+J9/z2R06I6fKllggQ49piLNYB1WbiHS
         IsCQ==
X-Gm-Message-State: AOJu0YziH1smsoNPcZsUBmklBFi+/59N/qnA4AnhS3hDu1EfucMwn8SJ
	oM8vVkp1yAgjpvmIosrlSy2KtgJxLlq0RtZaszYyPd/ay3tNeQ1QfSwWTmwFz++VMYZg+TPU6GX
	ZZ5lyaty6Z+8ZsynPyrMnjeZ+jxbWvgFNskTMnMN8L7QarKmCQCTP6hEo7CEI4w75Ug==
X-Received: by 2002:a17:90b:354b:b0:299:54bb:5cac with SMTP id lt11-20020a17090b354b00b0029954bb5cacmr3913136pjb.11.1708874180950;
        Sun, 25 Feb 2024 07:16:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyzwLdYBicxoHOrvuW46D9cxIj47JND9v9kRBsMuQZhq2Q9q6JGiZMK4gpqDj0j1YkLo90VA==
X-Received: by 2002:a17:90b:354b:b0:299:54bb:5cac with SMTP id lt11-20020a17090b354b00b0029954bb5cacmr3913117pjb.11.1708874180586;
        Sun, 25 Feb 2024 07:16:20 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id fy16-20020a17090b021000b0029aac9c523fsm1635539pjb.47.2024.02.25.07.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 07:16:20 -0800 (PST)
Date: Sun, 25 Feb 2024 23:16:16 +0800
From: Zorro Lang <zlang@redhat.com>
To: David Sterba <dsterba@suse.cz>
Cc: fstests@vger.kernel.org
Subject: Re: Dangerous commands (was:[ANNOUNCE] fstests: for-next branch
 updated to v2024.02.04)
Message-ID: <20240225151616.owk5v4ioplhrioe6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240221140951.GJ355@suse.cz>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221140951.GJ355@suse.cz>

On Wed, Feb 21, 2024 at 03:09:51PM +0100, David Sterba wrote:
> Hi,
> 
> reading [1] and how late it was found that effectively a "rm -rf /" can
> happen makes me worried about what I can expect from fstests after git
> pull. Many people contribute and the number for custom _cleanup()
> functions with unquoted 'rm' commands is just asking for more problems.
> 
> [1] https://lore.kernel.org/all/20240205060016.7fgiyafbnrvf5chj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
> 
> Unquoted arguments in shell scripts is IMO a big anti-pattern,
> unfortunately present everywhere in xfstests since the beginning.
> Rewriting all scripts would be quite a lot of work, could you at least
> provide safe versions of the cleanup helpers?

Hi David,

Thanks for taking care about it :)

> 
> For example:
> 
> _rm_tmp() {
>     rm -rf -- $tmp

It's "$tmp.*"

May I ask what problem does the "--" hope to avoid? If the "$tmp" is empty,
"rm -rf" and "rm -rf --"" looks like both doing nothing. So what kind
of situation does the "--" hope to fix?

The root problem in above [1] is about "${FOO}*". If someone does "rm -rf ${FOO}*"
in its custom _cleanup_xxxxx function, then it's dangerous if "$FOO" is empty.

I thought some ways to avoid that:
1) Try to avoid doing rm -rf ${FOO}*, if not necessary.
2) Must checks [ -n "$FOO" ] before doing any rm -rf ${FOO}*
3) Someone's custom _cleanup_xxxxx better to be called before default _cleanup
does "cd /".
4) Think about bringing in someone "Static program analysis" tool about bash
script, but I don't know if there're someone good, feel free to give me
suggestions.

> }
> 
> and used as
> 
> _cleanup() {
>     _rm_tmp
> }
> 
> or at least mandate the "--" separator and quoting arguments in new code
> and gradually fix the existing code.
> 
> I can send patches at least for btrfs and generic as this affects me but
> first I'd like to know that this will become standard coding style
> requirement in fstests.

If you'd like to send a patch to cleanup the cleanup things, that's welcome.
(just don't bring in regression issue, please:)

> 

