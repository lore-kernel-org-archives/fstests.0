Received: from mx1.redhat.com ([209.132.183.28]:54212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbeLTCRD (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 19 Dec 2018 21:17:03 -0500
Date: Wed, 19 Dec 2018 21:17:02 -0500 (EST)
From: Xiaoli Feng <xifeng@redhat.com>
Message-ID: <966737066.61401666.1545272222334.JavaMail.zimbra@redhat.com>
In-Reply-To: <20181219071834.GA14993@infradead.org>
References: <1545191068-6719-1-git-send-email-xifeng@redhat.com> <20181219071834.GA14993@infradead.org>
Subject: Re: [PATCH v1] xfstests: filter the default EA
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org, smfrench@gmail.com, Ronnie Sahlberg <lsahlber@redhat.com>, sprabhu <sprabhu@redhat.co>, linux-cifs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Christoph,

----- Original Message -----
> From: "Christoph Hellwig" <hch@infradead.org>
> To: "XiaoLi Feng" <xifeng@redhat.com>
> Cc: fstests@vger.kernel.org
> Sent: Wednesday, December 19, 2018 3:18:34 PM
> Subject: Re: [PATCH v1] xfstests: filter the default EA
> 
> On Wed, Dec 19, 2018 at 11:44:28AM +0800, XiaoLi Feng wrote:
> > From: xiaoli feng <xifeng@redhat.com>
> > 
> > For some filesystems, such as CIFS, the file or directory has the
> > default extend attribute. It makes these tests generic/020
> > generic/337 generic/377 failed. Now add this patch to filter the
> > default EA.
> 
> What is "the default EA"?  This sounds like a CIFS bug to me.

the default EA means the new file or directory has extended attributes.

# touch cifs/file
# getfattr cifs/file
# file: cifs/file
user.security.selinux

I don't think it's a CIFS bug to me. But we need the CIFS developers's
analysis. cc the cifs developer mail.

Thanks.
> 
