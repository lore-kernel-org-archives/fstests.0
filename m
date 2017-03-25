Received: from mx1.redhat.com ([209.132.183.28]:52096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751680AbdCYSOo (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 25 Mar 2017 14:14:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E8BD085543
        for <fstests@vger.kernel.org>; Sat, 25 Mar 2017 18:14:43 +0000 (UTC)
Date: Sun, 26 Mar 2017 02:14:40 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v8 1/2] fsstress: add mwrite/mread into test operation
 list
Message-ID: <20170325181440.GM14226@eguan.usersys.redhat.com>
References: <1490256627-32034-1-git-send-email-zlang@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490256627-32034-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 23, 2017 at 04:10:26PM +0800, Zorro Lang wrote:
> mmap as a popular and basic operation, most of softwares use it to
> access files. More and more customers report bugs related with
> mmap/munmap and other stress conditions.
>=20
> So add mmap read/write test into fsstress to increase mmap related
> stress to reproduce or find more bugs easily.
>=20
> Signed-off-by: Zorro Lang <zlang@redhat.com>

generic/270 failed in my release testing because fsstress processes
exited early than expected and killall complained no process to kill.

+/tmp/4881.fsstress.bin: no process found

This is because mwrite would trigger SIGBUS if it's writing to a mmap'ed
hole and there's no space left on device, so fsstress processes are
killed by SIGBUS.

Perhaps SIGBUS should be caught and handled so that fsstress won't be
killed. I'll drop this patchset for now.

Thanks,
Eryu
--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3=
A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR=
8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=
=3D2t9HwWh4wP8emNipoxUCyrfBolWLtO4Wo7L03917srA&s=3DlkhxQRQxn4bXpG6hIo_G2QfP=
29bYUIN8QQ9D32aQIEM&e=3D=20
