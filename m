Received: from bombadil.infradead.org ([198.137.202.133]:55664 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728966AbeLTHl1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 20 Dec 2018 02:41:27 -0500
Date: Wed, 19 Dec 2018 23:41:25 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v1] xfstests: filter the default EA
Message-ID: <20181220074125.GA24403@infradead.org>
References: <1545191068-6719-1-git-send-email-xifeng@redhat.com>
 <20181219071834.GA14993@infradead.org>
 <966737066.61401666.1545272222334.JavaMail.zimbra@redhat.com>
 <CAH2r5mueD3quzrQ=pnY+w1H9T7FDK5tfmif-AoBJ66a-LVhK=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mueD3quzrQ=pnY+w1H9T7FDK5tfmif-AoBJ66a-LVhK=A@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Steve French <smfrench@gmail.com>
Cc: Xiaoli Feng <xifeng@redhat.com>, Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>, sprabhu <sprabhu@redhat.co>, CIFS <linux-cifs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 19, 2018 at 08:24:26PM -0600, Steve French wrote:
> > # touch cifs/file
> > # getfattr cifs/file
> > # file: cifs/file
> > user.security.selinux
> 
> user.security.selinux is not a cifs EA.  This "default EA" is not
> handled/returned by CIFS.

The user. prefix for security.selinux is bogus.  Someone on either
the server or client side has a bad bug here.
