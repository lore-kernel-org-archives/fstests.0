Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F40D33F8AE
	for <fstests@vger.kernel.org>; Thu, 13 Nov 2025 11:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034720; cv=none; b=rjixOtDXPr0JqPgizKWGzwYXEMFVc7p6CQ43GaX94Uz3PEZyfd4Si266a+ccj1JU8Fb7ZU4/ZT2FabGtHuaW8CnlcsgIOAz0dTQSgRQm/Y5phM7ZdGq+SePvtTHB8GwvfTohryZf37sC8nvZ21gWVEcx0YBLT5+KLI3lbnt0/ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034720; c=relaxed/simple;
	bh=kD2YUiGDbyiYlq95KJ3XiI0c1LAn1KcgrND6++o0tsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TljwO0xNzANvdEgVzkz/qWiJl5MLGqaGfTQLxolTneDmsD3ZCSBcekChqwU2Jk3M6pllXdjNPqrXTmUQhDrIYovB37TMW/efLhsSr4Bbo9/ZRBCXkjvSSBTDbaVuVXIHBXIH4QzKA2nCcsuenVU4mdB/KnQWpy770eJm5PSZw9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K8lw9mr1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FPcCnG3i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8lw9mr1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FPcCnG3i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763034717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dabx+6EH/9u0kdFwkmBGsgarWdsFVWOkofePnXGY/+M=;
	b=K8lw9mr1uf4au5ZDiBaYfgvhOPJ8iJ5d1H9TQIyKuK6OHYhTcenZTmN2KhpsA5Kapb+FAC
	4dOoXYvNw435NpYFSEhKfsAt2Gk9/cG2iRH+rGOGXMTbBpQgPPfPawthFjuG7LU7JA2QXE
	89Vaitvtzd7rpK6IjuaCy4pjGLqU594=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-jccGiN_TMQ2dW5RDvnca7g-1; Thu, 13 Nov 2025 06:51:56 -0500
X-MC-Unique: jccGiN_TMQ2dW5RDvnca7g-1
X-Mimecast-MFC-AGG-ID: jccGiN_TMQ2dW5RDvnca7g_1763034716
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8803f43073bso25939286d6.0
        for <fstests@vger.kernel.org>; Thu, 13 Nov 2025 03:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763034716; x=1763639516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dabx+6EH/9u0kdFwkmBGsgarWdsFVWOkofePnXGY/+M=;
        b=FPcCnG3iPiR62XWfpD+OlVB1EKWRG9XILn+9V7mP+l6qrXUI+7k3A/2vS+tyGn6fzg
         Y9GbB9ZBktsnZJ2M3WzCFC2KRGo4pIEptPfO8D2dhN7M0fiKEcVqF7dbfU922PUbycxl
         C8eCqbNAqCPfzRRhlWbYs6KdCL8/N6ZFnK8idXfPxFdjQFtn9og+9dlGS5vLXrFauvhs
         O6W6eMKL5oWJpqQaGIrIbXTM1907BevUc0OCrimC5NkdJ3cQCPhK+bXSyCjx4TWuXmiu
         z6B/rfrGZjpBgJgiT7Yh766Z50p/1yPux9gKN983uX+UCFb2fjy3ElUs1eQUFNjvMInD
         0hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763034716; x=1763639516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dabx+6EH/9u0kdFwkmBGsgarWdsFVWOkofePnXGY/+M=;
        b=GQeoMChMtnM4+VmVJa7v/PFeOMOvWJ45H00Brk0SkREIdgwvuf/sIGEy8EeXzjnTBe
         S822AP8O84oRFPB7WpF7ASBLq+m/gmhaTQOX+bVqwJQ6f8uonFaQR4gfkH/d5clWoX3S
         79Y9yZr7NIxTuWYDADKbFlVd8Pq8vrbvZVm+2Y2GuK8bgwiQx244E+Fgs95LbqKFJB4o
         eFD6Gm38PwEYalhh3Wm0lN9bVVLkzZz4SnNCgMiF81X9FDbnFDBEbdCu6UUPyFoe1hLD
         WSflneu8hzDunb6iIXxbTaD4yT9K+S87sCDIpUJOe/qbYyWLI9VecjGt7C6husYpKy7O
         CN3g==
X-Gm-Message-State: AOJu0Yw9rE11lEsYgG1ce8KolrU8N5CHFIfyBb4gXl5TEHbp2AK7jyAm
	gBGc443d/YymCCdfF+eyehMRgNyZB1jRSbD/EbA1ebcAl5ek2PfKUY05sDcQGQ3KVRTS30l/meW
	jAyoHAa9pL47Agm2q+517qhB8pXXLu109+1vJJq25ZJypSjL9gmGzQYt5amLjCROHGtHXxuJGvh
	qs0a5hBlfWWaeqpFRZQlCUNfXdvZ/McJeZvApyFaHrc1IjWg==
X-Gm-Gg: ASbGnct8DskMGUBFaOITwXydR5I3R41s0VMXMjoEsgGKfp8lM+Bqmu9DY76Oqx912JT
	YuZlyn0e1By+rbwdZPAsJLkTiHpwnn/Wlpgx3SQ1pD5ftLTIE05SEoCHzdoNTvtPq0Vp51XDrwR
	n5qb+sdzPKbWLz1lazWEi8f4Mb7PHfuqakm3dyEsQ3HjW4qZGJ99GHQJTlPeg9miSfBpcThRTF6
	IS9gmb+Y6kBPEVmV43pjYIu6HY2K7uLS6CeCN19/NYFVh/QplTl6j7AiGVgohxqlwvDLguzlY5G
	1cS044tvrpIxbz59MqAAXw/gKND1CdPHVvOhZ3WY07w3fWBx7fHfslM4DTcRU/K2cZEJlvA=
X-Received: by 2002:a05:6214:1303:b0:87d:e32:81c5 with SMTP id 6a1803df08f44-88271975cb9mr81365776d6.20.1763034715979;
        Thu, 13 Nov 2025 03:51:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXdJgxIleXSxB45TXo0rBfQZlEHqe5/WPAxWn56XovhWJPy+VzLICED38Ou5AUHdPvRBGeMg==
X-Received: by 2002:a05:6214:1303:b0:87d:e32:81c5 with SMTP id 6a1803df08f44-88271975cb9mr81365566d6.20.1763034715564;
        Thu, 13 Nov 2025 03:51:55 -0800 (PST)
Received: from fedorakvm ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828652d941sm10112246d6.30.2025.11.13.03.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 03:51:55 -0800 (PST)
From: Ravi Singh <ravising@redhat.com>
To: fstests@vger.kernel.org
Cc: djwong@kernel.org
Subject: [PATCH v2 0/1] README: improve README formatting and clarity
Date: Thu, 13 Nov 2025 06:51:34 -0500
Message-ID: <20251113115135.609307-1-ravising@redhat.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This patch updates the README examples to use the root shell prompt '#'
instead of '$'. This aligns the documentation examples with typical
shell conventions and reviewer feedback.

Changes since v1:
 - Replaced '$' with '#' in example shell commands
 - Addressed reviewer feedback about correct prompt usage

Thanks for the review and feedback!

Ravi Singh (1):
  README: improve README formatting and clarity

 README | 70 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 37 insertions(+), 33 deletions(-)

-- 
2.51.1

