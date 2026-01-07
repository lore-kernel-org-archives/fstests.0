Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C555523EABB
	for <fstests@vger.kernel.org>; Wed,  7 Jan 2026 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767773584; cv=pass; b=eXPcG73hPcwDWaQ2Y95D5V+EmGOd4pH1dgasfQT9wbuuT8IJD6QXH2wpwgvcvua8M178Z+OpDZATcYcrIYMnHMSSnuwbV8UK/ydByegcLUZ7sbzoPw+soR5qi8TbSnEk6chLYCWwSVhVgFfZKKf8uutUuaWNkATBGGA20t4ovdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767773584; c=relaxed/simple;
	bh=np+1OvCR9etZAJudOaFhzEF4IUTA1FL9DDWrUvI8jHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYeqD3fRxrenqaBEdZtTlv3OIMwq+gUCnDXPjkKYRsxlV5WmeeL7HPXs011euLcPp381wokgB9agjfI7OA6XTZDN4pP5RhuPv44l2YPf4bmkzoiv2a1YFh71J+b0K3BLAKX+Tew2krssOkIzMHnIePt6LvcYeRFcWfxOk/JUC54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jzkvq01h; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jzkvq01h"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64b66d427e9so4480a12.1
        for <fstests@vger.kernel.org>; Wed, 07 Jan 2026 00:13:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767773581; cv=none;
        d=google.com; s=arc-20240605;
        b=L3HXpvjc2Oh7b3OV9J1V9kED1W2xuwIwhflAyDk5Mdm8rH65by8vmayyOLti4UYlvr
         yXx9NnufAbgJF9nA6SzV+ObjctZTky2WikAxcFEjWnhXE+3om7b8Frt8lwtoQhPMtn9A
         GHqyi0QwqBODkefD08WNsNIT4uR9kT87NdhO38oariOGNjhrK9++3HmL0Ed3O6S44KYz
         mHvFGIfAz2lFhFlZBGkVWYCVz7GmlLX7bRa8WKP3KQkEbuk7TB3NJLG9zkQcTkdujXOv
         c2VEgceJOYrJGm6htFcqJDwRit06Ow+RhDcYKHtR9P1rbu8mW8/AqIcLYhrjAmsg91Uh
         CMVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=db2x52HNhiU3vOiGT0b7DOt63jLzAg8/Ysh4HGphkRE=;
        fh=NPTbUm18Q+CRPuW9aBIO7Q3o93a1nTTECbY/U46KbDc=;
        b=dvsbBL25ZmUrvm5BJePX8mgSBXSm28jny7R/9dOqFu5QptnPq7ZGzMOcaHFRFOCNbl
         8oRZFavpJppgJfetsVhxXmiqECUo+nY95p1ltc/ErxCFuJOxGvQ3iHF3yo5jhqgMDo8F
         KLFVwIbCkQLEmqQ4gobCnELnSDXzzSbOodVWK6/BQsKKy17BkID8nYSW2BLISPa4AUoD
         bW0x2mTxo0p0D6VwXTJbBvel/jIGnmx4zkWNpa1yQuzRPV3MxSGiSQYvj1Gcea1qObfO
         9mDjgdtRuFUJ2rRJgu5VxsRp5FxuXY+B3jzqY9t7jTK2WlvokMJtNkZsA2zvfentgXH8
         ST6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767773581; x=1768378381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=db2x52HNhiU3vOiGT0b7DOt63jLzAg8/Ysh4HGphkRE=;
        b=Jzkvq01hQ4E6BfDr3SRM5OapVPuCmcdOOYn6JBJC3aIYYbynskb38dRn1K8kVAtlk/
         nNr2Z3aE2eU1lIOW1Mmt+BpaSH9wjv5cVJIhKCYfSrNZYD2adsx9rFKCXnbA0b6qb4RB
         5zAlObKLciYQOPF8K9/ozh5Fikk2YOZNXoR8pgItUTjqLMuoqYkVwYLMS2lJO/j6skfO
         9Q6/jEfh+KpJpA5wAuaxdYPzNWz9ORAnUeVlekyYoW+58CZETHbihFN4d91aQTn99hRv
         gn/LqgnHjzHQmsq2ndR41pWy3f1PiF6tlpgpmLxkvu20xG7d9tAG5js3nwZyZrlPZL6X
         KQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767773581; x=1768378381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=db2x52HNhiU3vOiGT0b7DOt63jLzAg8/Ysh4HGphkRE=;
        b=tIluEnVqJ3T7zVsNYycvxT/H9Z/EF8/eXLG4481SlWApNLWagEMKUIDgIMaHBtkzDX
         qNKqBUgFS9JXwSQ/SkyrsMUBhT95ELsIKzYXrG1I0Rje92PuvPT4PzRMJwdJE9JEjcL+
         pCPUu0kj3fZsW6Q/Sq6rq9fWOzsLPKr5C4tLh/rI4vTs6MjHC9ObfFIyGdZ22Qo8W7EY
         l9IbYpWhzDVtEWRZn/J3na1D/q/4FyWxBkBAk06uueDXvo85g5lMc7ts28HuxwNlDBTY
         h9CmMSCH/AnyLXRw1CvDMcVW6lhbQPVGVXpeDGq0RWmpG0qr/Uj9duQPK1tui1+CcEs2
         Diwg==
X-Forwarded-Encrypted: i=1; AJvYcCWIgfnAZyquoOKLSX1KjpFJNPK/xNebYK5K5ByHAwRyMCKxUhLFJKVJ//zz17HScb7ev6qwmAI+@vger.kernel.org
X-Gm-Message-State: AOJu0YwrZyFSpwRhnl6vGYbQd2/2r1A2RORuN1GVRUXTo8tPt5T5WTUr
	2ofdQACe7BMRkZ+Yn+CVPAxKFV1SNntcs1aIXO0b7j+hF7vkRIj8ePGAFR0nPD3UWA4Qr3aEV7P
	l8ZVfs/EHtcvZm/mHFmhr8ZN4hLPdYkzmKm00mdVp
X-Gm-Gg: AY/fxX4Z8WQVU23X8ZHhkybMJ2Y2U5qwd71Xmn7UHos4gzUE+RIPXjn+5IVCHdSu+iZ
	Fj2yv/N8qJWaJDQij8zUv4Y276DDPbVR+EQwGCeFkTsOVzlsP/HiwbTn/X+b3ZM5ciQrUpJhpkt
	Y2v/2zsD/cr30yoFye8gf9ywT4VQGEbydfvhXvQftyM/F2zT/biKK0NDjM8tz3Tzj8bmZ4xjzTO
	dTEt56ILKRcEPbxQFWEVWeVQkZidQOUIG1Pze/Ma3Jq8e8rCa1GyJ2t51belgVDxnN31kKyUHop
	jwPyq94OJk7zCPew34kM2uHMUQ==
X-Google-Smtp-Source: AGHT+IHpxxOKv4iSlqA1lieNBkvOv14hAOgXKfYnTG8DCgWnhfFB10pXU+bh4zfUI3iwjJ6zlvmC9mnz+/z5qjsb5/A=
X-Received: by 2002:aa7:d501:0:b0:624:45d0:4b33 with SMTP id
 4fb4d7f45d1cf-65097c38f5bmr20502a12.7.1767773580954; Wed, 07 Jan 2026
 00:13:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229023145.1806877-1-joannechien@google.com> <aV34aGUeU0pQkwj2@infradead.org>
In-Reply-To: <aV34aGUeU0pQkwj2@infradead.org>
From: Joanne Chang <joannechien@google.com>
Date: Wed, 7 Jan 2026 16:12:44 +0800
X-Gm-Features: AQt7F2rZ_GgTF8O1iiCWfD-1Mi_3j_bm97c1HStlDJJG0l0OHLHskCcjugup32s
Message-ID: <CACQK4XCF-Hex_H31evMu8Zpv_OLtV0QBU0MpajOSHcfaREMAKw@mail.gmail.com>
Subject: Re: [PATCH v2] common/rc: add _require_blocks_in_file helper
To: Christoph Hellwig <hch@infradead.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org, 
	Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, 
	Chao Yu <chao@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 2:08=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
> I still don't understand why we can't do this programmatically.  I guess
> it would be simply too slow?  In that case that should probably be
> documented here in the commit log.  Otherwise this looks good to me.

I used a constant to avoid masking bugs that cause the maximum file size
to shrink on filesystems that should support this test. I can add the
reason to the commit message if that would make it clearer.

Best regards,
Joanne
