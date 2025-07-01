Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5429813774D
	for <fstests@vger.kernel.org>; Tue,  1 Jul 2025 19:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751397328; cv=none; b=mfPsTlchCjOObBxkt162n0avo1DKX7MIlv8LV06AMIQ+x8HQNt9ZV5FTk091719bNNvuRMiiyfORc0qxsw24G/D5Rw+Bz4O+4uJxlZHm+/j0hSBD8DpydaC3vqTm2oHx3Z6FzKRy7Gdwq3xLmHJ5/EKcpBtIPUx3mZdHbIqD99U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751397328; c=relaxed/simple;
	bh=he0fxhWw7qvywN1/LvOaXKDiROiYd/HUiJxQaS+UlV0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=S14MrHdn1R+ha4PkzDtN2mcSBQ5P7IBSbKjQD1Oklm+w/QwyTYyqMvn7EnOhUgcHqIT5WI1w0yHNmBmYtSUaIrix+m7rcm6yM7a7HUI57ei1NaSUDb6dIOI9romxta8fle26B6M9HMQa2yj9Yi37MV9cq/mSmXT9QGAU7L62tbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZGMwwpW; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZGMwwpW"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6fad79433bbso34444306d6.0
        for <fstests@vger.kernel.org>; Tue, 01 Jul 2025 12:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751397326; x=1752002126; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X+Pc68ixWtxq+c9EvPB2oID4nRhLzRBACszuhtRgNlM=;
        b=UZGMwwpWX4N7HCLsGGc6TPibGkcDQirrGcllCqRA5i2lg1aZ2TFYo55p/hLMmUnq0z
         5UPiatvvp0qrUt68ZcvvRkrBYlx6g07qIn8z/iriJ+h5WMuP8hTBGTGP55XDVdcYDPsr
         2Om2IspU1U2xc8qWwnTr4pIaBPPOn6LXLk9XSA5hR6midAOj4r2s6W3LVmTerypcVBez
         qvpqm4trJaUztHFS2raxJuKjHM02rRktdfAg6dsozvbJyHh9/aflRtAeS/gBrChOVP1Y
         cwV0poYiw++B395PkWYHml8R6ryozJmHQqrZbNhKAY9DVDEvmWmPWDJPP+W3l47NHsLM
         cS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751397326; x=1752002126;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X+Pc68ixWtxq+c9EvPB2oID4nRhLzRBACszuhtRgNlM=;
        b=jjM1khh08w6dnGTRFBt9R5GcS/1v8lYso6Gck84APi7Aqn82Arxk5cjuov7u5i7Ws8
         yIjybulV7Umc6RVACCnbSOfJSqpnFJxw5ti4a0gmCXqAparjiJaK1sOAhtFfHAoWKdzm
         Tzq3bY9p5zudQaZ/nB4nhrMoCE5p0R99sgbJJWNlQ3z1NBWw1OdkeYl2KgR0egm9aJTY
         94QOEMFXi8R0dh9mm98w2M37fJgGzBQHVEdgYIByhTtUUgeKTUGMtD28cYFvbWlmGe1h
         /DH6jAvIj1NwoXJWXveHJ0M7F3DhpxGSMsI8CekwuV1I4t87U5DOCUUCb51+bSRSSsT7
         Xq7Q==
X-Gm-Message-State: AOJu0YwN9BjVQ8tcyGXBMbqHYQe8D9oa3gdydwOLi9gSy5QkfTUXSdbG
	x9f31oYAnlMxphQalEdnyfXhGMDsIEvsEz1qRSjg8B3vIFg4etYFHyIr7MOS68XVlWK2c2puNpY
	ynwvftLlvrpcg07JAXLNO0IWjY+Jn7g5d+jmn
X-Gm-Gg: ASbGncsC2anqfipq/aquXBQTlySdFP1Xw6dGiO/kSxGYTpvTRvTgkAdTbixDJyJVYE/
	wFblC0jQ7yJ1tJ1395w9WkxXY5HGYDhi7sS50uIia9gmbLzvF12pO6lFMHsQ8raciJxMqX5oQbU
	FAl5bVIvcmS3nklYiucqAKSPuZvrJfKNtZpeqBb6p+9SYUcuTIyaHZ
X-Google-Smtp-Source: AGHT+IE8WHXRrkkjbtV8He7ZIHzcV0orPYb5dmnB8EogJX/AuTTYw6x+0r1QqJnaOU/eFB9LcRgAMIvxYASN45W8JI4=
X-Received: by 2002:a05:6214:240b:b0:701:a1c:1a3b with SMTP id
 6a1803df08f44-7010a1c1ab3mr95609086d6.27.1751397325338; Tue, 01 Jul 2025
 12:15:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Tue, 1 Jul 2025 14:15:13 -0500
X-Gm-Features: Ac12FXz4S5-TFtF4uidOprdk4gsQvIbtnWudsSs4tCt4CNFcBOSj9Txe42bELlQ
Message-ID: <CAH2r5msYMeEaaKKT1mEG7bCjFYExFCRUdL6ShimoK0g1AEdERQ@mail.gmail.com>
Subject: Build errors with current xfstests
To: fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I am getting the following build error with current xfstests on
Ubuntu.  Any thoughts?

Building src
    [CC]    iogen
iogen.c: In function 'create_file':
iogen.c:996:3: error: #error Dont know how to (pre)allocate space!
  996 | # error Dont know how to (pre)allocate space!
      |   ^~~~~
iogen.c: In function 'main':
iogen.c:280:9: warning: ignoring return value of 'write' declared with
attribute 'warn_unused_result' [-Wunused-result]
  280 |         write(outfd, (char *)&req, sizeof(req));
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
iogen.c: In function 'parse_cmdline':
iogen.c:1535:17: warning: ignoring return value of 'getcwd' declared
with attribute 'warn_unused_result' [-Wunused-result]
 1535 |                 getcwd(fptr->f_path,
      |                 ^~~~~~~~~~~~~~~~~~~~
 1536 |                        sizeof(fptr->f_path)-1);
      |                        ~~~~~~~~~~~~~~~~~~~~~~~
gmake[2]: *** [Makefile:51: iogen] Error 1
gmake[1]: *** [include/buildrules:31: ltp] Error 2
make: *** [Makefile:51: default] Error 2



-- 
Thanks,

Steve
