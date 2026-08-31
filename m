Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10BB282F16
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 11:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175166; cv=pass; b=GWAyfjxYlXRXNEojYPGGofVqEcmduN17W5vSl092FX7Q5Vo0bO3KeTWSI/C2TilA/V8POsy2Q5iO9mYYE+wV98SUdZIloPRpsFIWu3/Aw6/OoSikIF/ff1/o+aEEJVGCxXjHMNEtagAiCi11rxouLyEdR7CGvQPlgq3OTEdjB78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175166; c=relaxed/simple;
	bh=sPwZ2rjGa4ORrMcBhiUq14r5UiTivTsJ0F6CWmTx5Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tpa9SGR8Reu+UJQCO0lz3r6+YFillEVYVFUE7eON5eA53DMlaNmJ/HHCGGcDp9XVb8X887W6QFPijV9pPrf+e9b5NUWIpJwjU2fWCDqouNGfMFGpYEaxNISLWfu4jIvQPzxLpSYP+BGRue07kgDhaDBhHKYg2m7ag8tUmWyiBEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qyCq6hqb; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyCq6hqb"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a156627e22so7853221a12.1
        for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 04:19:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788175163; cv=none;
        d=google.com; s=arc-20260327;
        b=HfQjEhQGaW6+GKE5Qz0w3ijEjlQyt49fbCfIo6P35QHVXsoX6TApWdD5c5I9VQAkUP
         yG7f1y/+ILh/F3cWpGX3kagMFTLTTroOKgkwWhMsnTHKvS4NWoyPl9QjUcuBiwutNmG7
         e4bA8s3feTBPDYtmauUXrSePmvagiP4dgqd9R1FOk0ueN95dtrdLywDszRMjEX1RULxi
         3ddTxk4WIfoa0unH07z+6ZJ7C3yKF5LN8u361aH8zpbHnhTUf/FTIqHZ20sC53XvNbPY
         YsAtatJqKM5UdRM7eGiHv8+c0Q2iH5bkg9IbHOpQ0CTDSflRqFu9wG9cbIYXzVidIQQO
         B2Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WPMZR1wY182SIo0vTA+fOa1hLZEIFYqeqqv+4/YgvXM=;
        fh=eW8f3VYcB8wgxVAJ8YhHCa1ZUrGHqjIiaoLmujEtgG0=;
        b=kmgaIrYGbJQa4GtehZPiKZeId1w1UbjosZ2MD6fnBnjBf22aSB8tquVUS4aKOrsTZR
         kYwKk1gfQ/XIEnM4A5xUDQlmFUek769ael1i2fZGAqxe0MsZYesrrpw7Bsg5ZSXaE+do
         s1DD/h/VrURoY0IKvAcRIr/BED5jlYaGPlYIWygkIVGvImSmARCKUCyXObxKQu7Zk/qe
         EULbSBmLOP4GW0EDqPKdXvaIK+AUfmZWA8Vvky0K+2mTRYcyyr2glg8pYUeemOUb9YbG
         1G8rWvxhQJ+BbpTGdvnqDG6ElcNP39r5jpH6um1BTfLUfLqWhKngaPXHz8QQbOsBVilS
         L4uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788175163; x=1788779963; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WPMZR1wY182SIo0vTA+fOa1hLZEIFYqeqqv+4/YgvXM=;
        b=qyCq6hqbVGW3o82MQ3x5y0C96Bqw50li1H4cx77OkHq51awNsfIvR/foHHpn+ZHRr3
         D+C5xJKEBydK3vchTAB0YNr+oGMnHELUm+ks+L7nZafvP//EOrtVZzkglkpXNo7+jPGE
         IOplyxsfZtWrkn03S5h87VXCGZCt8s/+GlAII32GKfg8KuGS4+1/7iCye63UNEft/+Rm
         8jCcVScaqmv0GSOIfGa3LGMx3pq29i/WkExRBc2KYWoq9kj5MbNzzWaHi1tnVe3oSYn/
         DJxUi4hzUDBV9onSNZb1xXIthRx44S/kaG26z+VKrOpn802C+p9LaIbH2vsEggM7RMDs
         RuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788175163; x=1788779963;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WPMZR1wY182SIo0vTA+fOa1hLZEIFYqeqqv+4/YgvXM=;
        b=hg92owAccyKTCIySR9yB+Ph+LXtAiFqhP5taLNm+3ZdGMHOIjLR7VlWyD1MaJA9mKu
         n5CDMpq9o3IqD2MKbPAsMTS+VCzYG09YrHtWof6sBFz8L4zfhDTCVZFQh+jN/TTwBZ29
         P24KC+u8EpLsrEEEhC6Xk4Dj8BtpqAzIKZ1es+/96wVnH3aUGz3ht/Dc6SH6VuN+J3ad
         auBa59eOIUjYiPOkLIM+3aDFgWsUis2eIXmpghAMJ8yGE3titq/dbsjGLubiMhqnLFKy
         U79ypzZgLaDx2zhRmF2187d67hOerZkw5tz1QlLUjZ4Wn7uI8DokpIZRBRPaY7V9ecL/
         xACA==
X-Gm-Message-State: AFuF++kijyGE2tiSeV/4vyLVaPtdcksrLW46zfYMNxmrHTT9xDC60nA2
	VLQ61Ft6qxtFz10T6BVUpeaCXMLykQ/ILHIpjVq/0LGeQMkUKzFpU+lut8g62ypyhBZJxnH4R9Z
	BRJcWVmcJGiERYs6pyDJrR/tuWjkMxQI=
X-Gm-Gg: AYBFou1q1KzcRj6SVfCW9S0K3cPWbTFpBEYy+7RWemERQFlB1+I0H33w0QDCR1JjJ3P
	4SD6HfbM4kzxDIlf06+eECwBjZY7FZxjKMCfgj42pAJVnRaCLeaPlR1A07pHr73ZBEt+sSsuxA8
	YNdljKr4egnvVDqBJz/Wi7/2CPOokSclMlGU3yC5iGCCYIjjXtddHQgjQGM+qbp+X5XMp8kfBm7
	3ebGW7itJhAHF9tA7pvQ05mwHmAP1H0wiLbtY4Lqs/kQd8RqT0FAakv62rxs/WdMhgINdZmZBXJ
	6v3gWflBjNUbPZL4Fpf60ymy0jQR8E4jVuGrW8av1+xfmg==
X-Received: by 2002:a05:6402:21c1:b0:6a6:32e2:fb49 with SMTP id
 4fb4d7f45d1cf-6a647796951mr4553257a12.11.1788175162309; Mon, 31 Aug 2026
 04:19:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831104154.2256-1-prabhakar.pujeri@dell.com>
In-Reply-To: <20260831104154.2256-1-prabhakar.pujeri@dell.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 31 Aug 2026 13:19:11 +0200
X-Gm-Features: AcwNN1XbV_zf11XWhT_g0nhVI9-LiZR6z645IAaToD4j_bzMvZZShqeTlCOznoU
Message-ID: <CAOQ4uxhg5qtjYHoCvGU=NCawg664HJmDkdau7HNScDRrV0-xSw@mail.gmail.com>
Subject: Re: [PATCH] overlay/081: add missing _require_scratch_nocheck check
To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
Cc: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 12:42=E2=80=AFPM Prabhakar Pujeri
<prabhakar.pujeri@dell.com> wrote:
>
> The test runs _scratch_mkfs without first requiring a scratch device, so
> it fails messily instead of skipping when no scratch device is
> configured.  Use _require_scratch_nocheck like the neighbouring tests
> overlay/079 and overlay/080, as the test mounts overlay on the base
> scratch fs.
>
> Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
> ---
>  tests/overlay/081 | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tests/overlay/081 b/tests/overlay/081
> index 2270a04..a13b785 100755
> --- a/tests/overlay/081
> +++ b/tests/overlay/081
> @@ -14,6 +14,9 @@ _begin_fstest auto quick
>  . ./common/filter
>  . ./common/attr
>
> +# We use non-default scratch underlying overlay dirs, we need to check
> +# them explicitly after test.
> +_require_scratch_nocheck

This copied comment is not true for this test
Not that it matters much because fsck.overlay is not maintained for
a long time, but I don't like to spread this wrong pattern, so please
use _require_scratch in this test.

Otherwise you can add
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.
