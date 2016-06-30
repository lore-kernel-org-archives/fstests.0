Received: from mail-vk0-f44.google.com ([209.85.213.44]:36639 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbcF3N3j (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 30 Jun 2016 09:29:39 -0400
Received: by mail-vk0-f44.google.com with SMTP id m127so49817133vkb.3
        for <fstests@vger.kernel.org>; Thu, 30 Jun 2016 06:29:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160630120038.GA23649@eguan.usersys.redhat.com>
References: <1467118046-27030-1-git-send-email-agruenba@redhat.com>
 <1467118046-27030-2-git-send-email-agruenba@redhat.com> <20160630120038.GA23649@eguan.usersys.redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 30 Jun 2016 15:29:27 +0200
Message-ID: <CAHc6FU6rRbPFYNjw9+yjCGCGOBux3fS9cXTEYex3XuNyMeNe7Q@mail.gmail.com>
Subject: Re: [PATCH v8] generic/362-370: Add richacl tests
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 30, 2016 at 2:00 PM, Eryu Guan <eguan@redhat.com> wrote:
> On Tue, Jun 28, 2016 at 02:47:26PM +0200, Andreas Gruenbacher wrote:
>> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
>
> The tests look fine to me. I compiled your richacl kernel & richacl
> tools & xfsprogs and tested them on XFS on ppc64 host, and they all
> passed. I've queued them up for next pull request. Thanks!

Thanks for putting in the effort!

Andreas
