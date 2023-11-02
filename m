Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487011C296
	for <fstests@vger.kernel.org>; Thu,  2 Nov 2023 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gw4JJOkT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDCB182
	for <fstests@vger.kernel.org>; Thu,  2 Nov 2023 07:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698935875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jsCF0i5O6/gTr16YZpNXJMk9ajCl+87XqCHuQIk8JQ=;
	b=Gw4JJOkTvey43NuMciJ+HzU1qRq9nesQdqfDEaJ1mnObOvHhootu5aB046r59RlKE9PDpt
	FnKcan0CzYYs+lM7gvTRiZFOhRV54lc6QuEuKsw814AMqFUTLwbo3UWPEj+NqoKDb57Wi1
	d4tAFpMGJslPLwi4za1ZAZBUhzfkWkQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-5mBTm-QBNLaYOITJ14OR8w-1; Thu, 02 Nov 2023 10:37:54 -0400
X-MC-Unique: 5mBTm-QBNLaYOITJ14OR8w-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9c7558b89ccso69880666b.3
        for <fstests@vger.kernel.org>; Thu, 02 Nov 2023 07:37:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698935873; x=1699540673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jsCF0i5O6/gTr16YZpNXJMk9ajCl+87XqCHuQIk8JQ=;
        b=LudL176PIs5Y1BySFQvkgT8yk7ruvlKJS6PBFW+t3pqC2Z9FQ2im0s67fhBv57kt6t
         W2P5SKfAUcgObpnjxWr39/GZQM5ubqvLM6dQq6Ez5JWXcCxTNJYCJqsTQE99TIlmEOqf
         VWcePwoXC0EAtRLgYvqlyjXc4L6EqAq4xvk/7KZUbxLMvFPLSisMWEv5zi2yY7QcIuJd
         s9RzyruJU7PIHXSnZ2jYlZhDGA/1Z5GPS5K7o+P82emgXSx07gnOaGF+tIpeh/+bw/WG
         OmUNS1+wNQnldz/+vl4dFgn6jvrtTXn4lTrpo8InLJCXqZD1G4cWfpHj8gkN0R989oXi
         nfvQ==
X-Gm-Message-State: AOJu0YxpKnB36MogATekOo7q7V5Fp6V6El8mBTyNer8vOpOUSjKvgk8a
	5esd0x2GZFXImjjLiQ2ciGmrBcU8oGsk47zbepT8Qk1bdRM6ZLi+hVY7T7sKDgQ2OnM0q6hhcnF
	XRFlBLsDechofHwhdKtyhIoDtgJb/smsboXLHgItqnw==
X-Received: by 2002:a17:906:c115:b0:9d2:63ab:6d4f with SMTP id do21-20020a170906c11500b009d263ab6d4fmr4566401ejc.55.1698935873325;
        Thu, 02 Nov 2023 07:37:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERhFhafae76zUUdYJkyHMjhO18uMk2/F3HJt78Ghicsp55KLISPLQmp4pEBzxjiuTwfkA2ALEKRA7R02mMtlM=
X-Received: by 2002:a17:906:c115:b0:9d2:63ab:6d4f with SMTP id
 do21-20020a170906c11500b009d263ab6d4fmr4566388ejc.55.1698935873065; Thu, 02
 Nov 2023 07:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925201827.1703857-1-aahringo@redhat.com>
In-Reply-To: <20230925201827.1703857-1-aahringo@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 2 Nov 2023 10:37:41 -0400
Message-ID: <CAK-6q+hrsfCn+y3yjqnti9JUfSOhOWgiEtSioukL5H3dA6-_8A@mail.gmail.com>
Subject: Re: [PATCHv2] generic: add fcntl corner cases tests
To: fstests@vger.kernel.org
Cc: zlang@redhat.com, gfs2@lists.linux.dev, jlayton@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 25, 2023 at 4:18=E2=80=AFPM Alexander Aring <aahringo@redhat.co=
m> wrote:
>
> This patch adds fcntl corner cases that was being used to confirm issues
> on a GFS2 filesystem. The GFS2 filesystem has it's own ->lock()
> implementation and in those corner cases issues was being found and
> fixed.
>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
> changes since v2:
> - move fcntl tests into one fcntl c file
> - remove ofd and same owner tests, should be reflected by only one test
> - simplify commit message (remove testname out of it)
> - add error messages in fcntl.c to give more information if an error
>   occur

ping, any comments? Would for me nice to have these fcntl() tests
upstream and have a starting point to add more tests regarding dlm
plock implementation.

Thanks.

 - Alex

