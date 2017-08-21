Received: from mail-wr0-f179.google.com ([209.85.128.179]:37385 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbdHUOmq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Aug 2017 10:42:46 -0400
MIME-Version: 1.0
In-Reply-To: <CADxRZqyTse068Pt8xsAyehEJoHA7jQ6vPH4WCVyxrzEjYjpA1Q@mail.gmail.com>
References: <CADxRZqykqGycgPh5O9C1F_Eq0J_rP-95zxesDkSDbkLD=04uYA@mail.gmail.com>
 <CADxRZqz_m69YL214tiimqCQ-+pYAvc1UFO_HgvTdKKok0_LzXw@mail.gmail.com>
 <CADxRZqyHkwT+HVTQopDZYiAwkCAkBDvPM0eY-Cqw6e5XuzcZ5Q@mail.gmail.com>
 <CADxRZqwe71WZ2=9Xecash65zdk2HmaRffoiCWjwQCHzub3tdvQ@mail.gmail.com> <CADxRZqyTse068Pt8xsAyehEJoHA7jQ6vPH4WCVyxrzEjYjpA1Q@mail.gmail.com>
From: Anatoly Pugachev <matorola@gmail.com>
Date: Mon, 21 Aug 2017 17:42:44 +0300
Message-ID: <CADxRZqwRL1tQ=6KGDzTFJt62bWQ_eN__Yu8UF02pk0beFejwoQ@mail.gmail.com>
Subject: Re: [xfstests, sparc64] git kernel OOPS 4.13.0-rc5+
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: lvm-devel@redhat.com
Cc: Sparc kernel list <sparclinux@vger.kernel.org>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Compiling git kernel with gcc-7.2 and with patch [1] fixes OOPS on
xfstests as well.

1. "[sparc64] kernel OOPS with gcc 7.1 / 7.2"
https://marc.info/?l=gcc&m=150285790205560&w=2
