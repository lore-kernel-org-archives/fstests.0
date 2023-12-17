Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FE61DFD4
	for <fstests@vger.kernel.org>; Sun, 17 Dec 2023 18:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHJAydOd"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-67f2f1008e1so7656246d6.1
        for <fstests@vger.kernel.org>; Sun, 17 Dec 2023 10:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702838762; x=1703443562; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TB1M1QLe4scL1dsGM+msSocq7XZyDYsmK+XFDNFDjlU=;
        b=HHJAydOdbagWejtuwbh4U2QKHSuT8Uh4miyVs54N0AF4meH/2Sm73FFqIcOTld4C4Y
         oM4H0nolhBVgYhaVE3G7yJlybDzMpwfRiWbZJ+r87XOQrWCgLlpM3al8BXAI3TdCLKjK
         X/hgZ5SSqa1a4145m1bc312lkD3Cp1U0oKuv24I+vPPof1y+T+BakTN+PWI6qhBlDatc
         jwBR/SOgHYlf7lmDZ41RgUCyCpERRUs1zDZqvEBF9b8iDLOH9ZCclIGFvTauNZRwc0aL
         3pK3wEdLzJR6IBxo0tf2gE5+o4/4vDbHDGsVQEAJvLzm0SUA8iSyGk05SmTFnXqhrZc9
         qv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702838762; x=1703443562;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TB1M1QLe4scL1dsGM+msSocq7XZyDYsmK+XFDNFDjlU=;
        b=p04ihY3V+1fXG/wZ7+tXssnYC03GgttPieAHIgbJ7MhUJPJuc441FPjfpKPGLSEHli
         dZrc4aLFEg5hSGgIxrmkcLUGM30xaoG020LSu8q2NoA+b27kdbFxpwPs13q36MnR0w0v
         ooJPiikeBx06UWuqYQM4NV1MXnAshY9lQ3tmG0SXtvDpKFZNie5Jyirtr7W4VtD9+Fsi
         O+wCuF2nxWT9d7w9Pzig/+mfTl/iaB/Cz/VeUEI1VYdiD8Y7BhmFrYoSHGlMDKrt+VNN
         FcdQSSWL9nckyW2h1wnV0VCTv9CPehg4jzwMC8Q2mZ2544EcDRw08Z3qt7UYqk/C1vD5
         YFog==
X-Gm-Message-State: AOJu0Ywf9FURKaq8YyhT2hgh2L3YDAW8/1CykV4aLcs5lH6F1mU4HHzM
	TsdZssSR3pOKkMD8yTORhnWsZRDcT6rVB/sssk6UumzIJlFdjA==
X-Google-Smtp-Source: AGHT+IGiiTUn5CoK8jk469qprQtAJJvVpMiRZMVrcEr8i/rvochp3DIWfRRTSJLjLNzMhZBHEGxVy1j+XQ3Ykzkzq2U=
X-Received: by 2002:a05:6214:226a:b0:67f:2201:81df with SMTP id
 gs10-20020a056214226a00b0067f220181dfmr5182636qvb.28.1702838762264; Sun, 17
 Dec 2023 10:46:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN_LGv38+54CQrSb=Xod2-g5Tge2ViTT1jpMu25UGN144AEqgg@mail.gmail.com>
In-Reply-To: <CAN_LGv38+54CQrSb=Xod2-g5Tge2ViTT1jpMu25UGN144AEqgg@mail.gmail.com>
From: "Alexander E. Patrakov" <patrakov@gmail.com>
Date: Mon, 18 Dec 2023 02:45:36 +0800
Message-ID: <CAN_LGv2UUOZvxN6w83tLudPZ5O9VPN0aJVDJay4rJDsvtcn29Q@mail.gmail.com>
Subject: Re: Excessive media wearout caused by generic/129
To: fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 11:43=E2=80=AFPM Alexander E. Patrakov
<patrakov@gmail.com> wrote:
>
> Hello.
>
> While running xfstests on an SMB share exposed by a Windows Server
> 2022 VM running on my laptop, I found an unpleasant surprise: a single
> run subtracted 1.5% of the write resource of my SSD, which is quite a
> lot. Could you please modify the test to avoid this booby trap? Or
> actually, let me do it myself...

The same concern, with the same root cause (truncation at a
hundred-megabyte offset being transformed into a hundred-megabyte
write, and then repeated 10000 times), exists for generic/014. At this
point, I have a question: should this be mitigated at the individual
test level, or should the _require_sparse_files check be modified?

--=20
Alexander E. Patrakov
