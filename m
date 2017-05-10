Received: from aserp1040.oracle.com ([141.146.126.69]:29941 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbdEJWkX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 10 May 2017 18:40:23 -0400
Subject: Re: [PATCH 3/9] bio-integrity:  bio_integrity_advance must update integrity seed
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1494429652-9488-1-git-send-email-dmonakhov@openvz.org>
        <1494429652-9488-4-git-send-email-dmonakhov@openvz.org>
Date: Wed, 10 May 2017 18:40:13 -0400
In-Reply-To: <1494429652-9488-4-git-send-email-dmonakhov@openvz.org> (Dmitry
        Monakhov's message of "Wed, 10 May 2017 19:20:46 +0400")
Message-ID: <yq1pofgmj3m.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


Dmitry,

> SCSI drivers do care about bip_seed so we must update it accordingly.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
